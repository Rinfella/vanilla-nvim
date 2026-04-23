-- lua/plugins/coding.lua
return {
    -- Mason (Installer Only)
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        opts = { ui = { border = "rounded" } },
    },

    -- Completion Engine
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            require("luasnip.loaders.from_vscode").lazy_load()

            local has_words_before = function()
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col > 1 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col - 1, col - 1):match("%s") == nil
            end

            cmp.setup({
                snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                }),
            })
        end,
    },

    -- Treesitter - Disabled. Neovim 0.12+ has built-in treesitter support.
    -- Using native: syntax highlighting, indentation via vim.treesitter API
    -- To enable: install parsers via :TSInstall or :lua vim.treesitter.start()
    -- {
    --     "nvim-treesitter/nvim-treesitter",
    -- },

    -- Multi-cursor (No native alternative)
    {
        "mg979/vim-visual-multi",
        event = "BufRead",
    },

    -- Lightweight formatter (Native alternative: use vim.lsp.buf.format)
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "black" },
                php = { "php_cs_fixer" },
                go = { "goimports", "gofmt" },
                rust = { "rustfmt" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                json = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },
            },
        },
    },
}
