local cmp = require("cmp")
local luasnip = require("luasnip")

-- Lazy load VSCode-style snippets
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup()

-- Function to disable Copilot suggestions when snippets/completion menu is active
local function configure_copilot_toggle()
    local copilot_ok, copilot = pcall(require, "copilot.suggestion")
    if not copilot_ok then return end

    local function set_trigger(trigger)
        vim.b.copilot_suggestion_auto_trigger = trigger
        vim.b.copilot_suggestion_hidden = not trigger
    end

    cmp.event:on("menu_opened", function()
        if copilot.is_visible() then copilot.dismiss() end
        set_trigger(false)
    end)

    cmp.event:on("menu_closed", function()
        set_trigger(not luasnip.expand_or_locally_jumpable())
    end)

    vim.api.nvim_create_autocmd("User", {
        pattern = { "LuasnipInsertNodeEnter", "LuasnipInsertNodeLeave" },
        callback = function()
            set_trigger(not luasnip.expand_or_locally_jumpable())
        end,
    })

    vim.api.nvim_create_autocmd('ModeChanged', {
        group = vim.api.nvim_create_augroup('UnlinkSnippetOnModeChange', { clear = true }),
        pattern = { 's:n', 'i:*' },
        callback = function(event)
            if luasnip.session and luasnip.session.current_nodes[event.buf] and not luasnip.session.jump_active then
                luasnip.unlink_current()
            end
        end,
    })
end

configure_copilot_toggle()

-- Keymap for backspace in snippet mode
vim.keymap.set('s', '<BS>', '<C-O>s')

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    preselect = cmp.PreselectMode.None,
    mapping = cmp.mapping.preset.insert {
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<M-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
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
    sources = cmp.config.sources({
        { name = 'copilot' },
        { name = 'codeium' },
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'lorem_ipsum' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'render-markdown' },
    }),
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    view = {
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
                Text          = "",
                Method        = "",
                Function      = "󰊕",
                Constructor   = "",
                Field         = "",
                Variable      = "󰫧",
                Class         = "",
                Interface     = "",
                Module        = "",
                Property      = "",
                Unit          = "",
                Value         = "󰎠",
                Enum          = "",
                Keyword       = "󰌋",
                Snippet       = "",
                Color         = "󰏘",
                File          = "󰈙",
                Reference     = "",
                Folder        = "",
                EnumMember    = "",
                Constant      = "󰏿",
                Struct        = "",
                Event         = "",
                Operator      = "󰆕",
                TypeParameter = "󰅲",
                Copilot       = "",
                Codeium       = "",
                Lorem         = "󰒕",
            }
            local icon = kind_icons[vim_item.kind] or ""
            vim_item.kind = string.format("%s %s", icon, vim_item.kind)
            vim_item.menu = ({
                codeium     = "[Codeium]",
                copilot     = "[Copilot]",
                nvim_lsp    = "[LSP]",
                buffer      = "[Buffer]",
                luasnip     = "[Snippet]",
                lorem_ipsum = "[Lorem Ipsum]",
                path        = "[Path]",
            })[entry.source.name] or "[Unknown]"
            return vim_item
        end
    },
}
