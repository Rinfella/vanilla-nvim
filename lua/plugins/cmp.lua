local cmp = require("cmp")
local luasnip = require("luasnip")

-- VSCode-style snippets
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup({
    history = true,
    delete_check_events = "TextChanged",
})

-- Setup copilot integration toggle
local function setup_copilot_toggle()
    local ok, copilot = pcall(require, "copilot.suggestion")
    if not ok then return end

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

setup_copilot_toggle()

-- Custom comparator for source priority
local function source_priority_comparator(entry1, entry2)
    local priority1 = entry1.source:get_source_config().priority or 0
    local priority2 = entry2.source:get_source_config().priority or 0

    if priority1 == priority2 then
        return nil -- Let other comparators decide
    end

    return priority2 < priority1 -- Higher priority comes first
end

-- Backspace in snippet mode
vim.keymap.set('s', '<BS>', '<C-O>s')

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    preselect = cmp.PreselectMode.None,
    mapping = cmp.mapping.preset.insert({
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<M-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
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
            if cmp.visible_docs() then cmp.close_docs() else cmp.open_docs() end
        end,
        ['-'] = cmp.mapping.close(),
    }),
    -- Sources with explicit priority (LSP > LLM > snippets > others)
    sources = cmp.config.sources({
        { name = 'nvim_lsp',    priority = 1000 }, -- Highest priority
        { name = 'codeium',     priority = 900 },  -- AI/LLM suggestions
        { name = 'copilot',     priority = 850 },  -- AI/LLM suggestions
        { name = 'luasnip',     priority = 750 },  -- Snippets
        { name = 'lorem_ipsum', priority = 700 },  -- Lorem ipsum
        { name = 'buffer',      priority = 500 },  -- Buffer content
        { name = 'path',        priority = 250 },  -- File paths
    }),
    window = {
        completion = cmp.config.window.bordered({
            border = "rounded",
            winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None"
        }),
        documentation = cmp.config.window.bordered({
            border = "rounded",
        }),
    },
    view = {
        docs = { auto_open = false },
        entries = {
            name = 'custom',
            selection_order = 'near_cursor',
        }
    },
    performance = {
        debounce = 60,
        throttle = 30,
        max_view_entries = 8,
        fetching_timeout = 200,
        filtering_context_budget = 10,
        confirm_resolve_timeout = 80,
        async_budget = 1,
    },
    completion = {
        completeopt = 'menu,menuone,noselect',
        keyword_length = 2,
    },
    sorting = {
        priority_weight = 2,
        comparators = {
            source_priority_comparator,
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },
    formatting = {
        fields = { "kind", "abbr", "menu" },
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
                File = "󰈙",
                Reference = "",
                Folder = "",
                EnumMember = "",
                Constant = "󰏿",
                Struct = "",
                Event = "",
                Operator = "󰆕",
                TypeParameter = "󰅲",
                Copilot = "",
                Codeium = "",
                Lorem = "󰒕",
            }

            -- Kind with icons
            vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind] or "", vim_item.kind)

            -- Source based menu
            vim_item.menu = ({
                nvim_lsp    = "[LSP]",
                codeium     = "[Codeium]",
                copilot     = "[Copilot]",
                luasnip     = "[Snippet]",
                lorem_ipsum = "[Lorem Ipsum]",
                buffer      = "[Buffer]",
                path        = "[Path]",
            })[entry.source.name] or "[?]"

            return vim_item
        end,
    },
    experimental = {
        ghost_text = {
            hl_group = "CmpGhostText",
        },
    },
})

-- Set configuration for specific filetype
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'buffer' },
    })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore)
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore)
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    }),
    matching = {
        disallow_symbol_nonprefix_matching = false,
        disallow_fuzzy_matching = false,
        disallow_fullfuzzy_matching = false,
        disallow_partial_fuzzy_matching = true,
        disallow_partial_matching = false,
        disallow_prefix_unmatching = false,
    }
})
