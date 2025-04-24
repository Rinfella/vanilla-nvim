-- Completion plugin configuration
local cmp = require("cmp")
local luasnip = require("luasnip")
local copilot = require("copilot.suggestion")

-- Load VSCode like snippets
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup()

-- Function to control Copilot trigger state
local function set_trigger(trigger)
    vim.b.copilot_suggestion_auto_trigger = trigger
    vim.b.copilot_suggestion_hidden = not trigger
end

-- Hide suggestions when the completion menu is open
cmp.event:on("menu_opened", function()
    if copilot.is_visible() then
        copilot.dismiss()
    end
    set_trigger(false)
end)

-- Disable suggestions when inside a snippet
cmp.event:on("menu_closed", function()
    set_trigger(not luasnip.expand_or_locally_jumpable())
end)

-- Add autocmd for LuaSnip events
vim.api.nvim_create_autocmd("User", {
    pattern = { "LuasnipInsertNodeEnter", "LuasnipInsertNodeLeave" },
    callback = function()
        set_trigger(not luasnip.expand_or_locally_jumpable())
    end,
})

-- HACK: Cancel the snippet session when leaving insert mode.
vim.api.nvim_create_autocmd('ModeChanged', {
    group = vim.api.nvim_create_augroup('UnlinkSnippetOnModeChange', { clear = true }),
    pattern = { 's:n', 'i:*' },
    callback = function(event)
        if
            luasnip.session
            and luasnip.session.current_nodes[event.buf]
            and not luasnip.session.jump_active
        then
            luasnip.unlink_current()
        end
    end,
})

-- Inside a snippet, use backspace to remove the placeholder
vim.keymap.set('s', '<BS>', '<C-O>s')

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    -- Disable preselect. On enter, the first thing will be used if nothing is selected.
    preselect = cmp.PreselectMode.None,
    mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<M-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if copilot.is_visible() then
                copilot.accept()
            elseif cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.expand_or_locally_jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<C-b>'] = function()
            if cmp.visible_docs() then
                cmp.close_docs()
            else
                cmp.open_docs()
            end
        end,
        ['/'] = cmp.mapping.close(),
    },
    sources = {
        { name = 'copilot' },
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'render-markdown' },
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    view = {
        -- Explicitly request documentation
        docs = { auto_open = false },
    },
    performance = {
        debounce = 0,
        throttle = 0,
        max_view_entries = 8,
        fetching_timeout = 50,
        filtering_context_budget = 100,
        confirm_resolve_timeout = 80,
        async_budget = 1,
    },
    completion = {
        completeopt = 'menu,menuone,noselect',
        keyword_length = 3,
    },
    formatting = {
        fields = { "abbr", "kind", "menu" },
        expandable_indicator = true,
        format = function(entry, vim_item)
            local kind_icons = {
                Text = "",
                Method = "",
                Function = "󰊕",
                Constructor = "",
                Field = "",
                Variable = "󰫧",
                Class = "",
                Interface = "",
                Module = "",
                Property = "",
                Unit = "",
                Value = "󰎠",
                Enum = "",
                Keyword = "󰌋",
                Snippet = "",
                Color = "󰏘",
                File = "",
                Reference = "",
                Folder = "",
                EnumMember = "",
                Constant = "󰏿",
                Struct = "",
                Event = "",
                Operator = "󰆕",
                TypeParameter = "󰅲",
                Copilot = "",
            }
            -- Ensure a valid kind icon exists
            local icon = kind_icons[vim_item.kind] or "" -- "" as fallback
            vim_item.kind = string.format("%s %s", icon, vim_item.kind)
            -- Optional: Show source name in menu (useful for debugging)
            vim_item.menu = ({
                copilot = "[Copilot]",
                nvim_lsp = "[LSP]",
                buffer = "[Buffer]",
                luasnip = "[Snippet]",
                path = "[Path]",
            })[entry.source.name] or "[Unknown]"
            return vim_item
        end
    },
}
