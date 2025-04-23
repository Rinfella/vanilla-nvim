-- Plugin Management using lazy.nvim

-- Bootstrap lazy.nvim if it does not exist
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "git@github.com:folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Load Plugins
require("lazy").setup({
    -- Core plugins
    -- Mason + LSP
    {
        "williamboman/mason.nvim",
        event = "VeryLazy",
    },

    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
        },


        config = function()
            require("plugins.lsp")
        end,
    },

    -- Neovim syntax
    {
        "folke/neodev.nvim",
    },


    -- Comments toggle
    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        config = function() require("Comment").setup() end
    },

    -- TODO Comments
    -- PERF:
    -- HACK:
    -- FIX:
    -- TODO:
    -- NOTE:
    -- WARNING:

    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {}
    },

    -- Theme and UI
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("plugins.ui")
        end,
    },

    -- Dashboard Alpha
    {
        "goolord/alpha-nvim",
        config = function()
            require("alpha").setup(
                require "alpha.themes.dashboard".config
            )
        end
    },

    -- Status Line
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
    },

    -- Completion
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            require("plugins.cmp")
        end,
    },

    -- Copilot
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("plugins.copilot").setup()
        end
    },

    -- Copilot-CMP
    {
        "zbirenbaum/copilot-cmp",
        dependencies = { "zbirenbaum/copilot.lua" },
        config = function()
            require("copilot_cmp").setup()
        end,
    },

    -- Codeium
    -- {
    --     "Exafunction/windsurf.nvim",
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --         "hrsh7th/nvim-cmp",
    --     },
    --     config = function()
    --         require("codeium").setup({
    --         })
    --     end
    -- },

    -- Auto Format
    {
        "https://git.sr.ht/~nedia/auto-format.nvim",
        event = "BufWinEnter",
        config = function()
            require("auto-format").setup()
        end
    },

    -- Auto Save
    {
        "https://git.sr.ht/~nedia/auto-save.nvim",
        event = { "BufReadPre" },
        opts = {
            events = { 'InsertLeave', 'BufLeave' },
            silent = false,
            exclude_ft = { 'neo-tree' },
        },
        config = function()
            require("plugins.autosave")
        end,
    },

    -- SCRETCH
    {
        "0xJohnnyboy/scretch.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        config = function()
            require("plugins.scretch")
            require("scretch").setup {}
        end,
    },

    -- Render Markdown
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {
            completions = {
                lsp = { enabled = true },
            },
        },
    },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            }
        },
        config = function()
            require("plugins.telescope")
        end,
    },

    -- Tree Sitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("plugins.treesitter")
        end,
    },

    -- File Explorer (Neotree)
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        cmd = "Neotree",
        config = function()
            require("nvim-web-devicons").setup { default = true }
            require("core.keymaps")
            require("neo-tree").setup({
                close_if_last_window = false,
                popup_border_style = "rounded",
                enable_git_status = true,
                enable_diagnostics = true,
                open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
                sort_case_insensitive = false,
                filesystem = {
                    filtered_items = {
                        visible = false,
                        hide_dotfiles = true,
                        hide_gitignored = true,
                        hide_hidden = true,
                    },
                    follow_current_file = {
                        enabled = true,
                    },
                    hijack_netrw_behavior = "open_default",
                },
                window = {
                    position = "left",
                    width = 30,
                },
            })
        end,
    },

    -- TROUBLE
    {
        "folke/trouble.nvim",
        opts = {},
        cmd = "Trouble",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>xs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>xl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
    },

    -- AutoPairs
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true
        -- use opts = {} for passing setup options
        -- this is equivalent to setup({}) function
    },

    -- CHEATSHEET NVIM
    {
        "doctorfree/cheatsheet.nvim",
        event = "VeryLazy",
        dependencies = {
            { "nvim-telescope/telescope.nvim" },
            { "nvim-lua/popup.nvim" },
            { "nvim-lua/plenary.nvim" },
        },
        config = function()
            local ctactions = require "cheatsheet.telescope.actions"
            require("cheatsheet").setup {
                bundled_cheetsheets = {
                    enabled = {
                        "default",
                        "lua",
                        "markdown",
                        "regex",
                        "netrw",
                        "unicode",
                    },

                    disabled = { "nerd-fonts" },
                },
                bundled_plugin_cheatsheets = {
                    enabled = {
                        "auto-session",
                        "goto-preview",
                        "octo.nvim",
                        "telescope.nvim",
                        "vim-easy-align",
                        "vim-sandwich",
                    },
                    disabled = { "gitsigns" },
                },
                include_only_installed_plugins = true,
                telescope_mappings = {
                    ["<CR>"] = ctactions.select_or_fill_commandline,
                    ["<A-CR>"] = ctactions.select_or_execute,
                    ["<C-Y>"] = ctactions.copy_cheat_value,
                    ["<C-E>"] = ctactions.edit_user_cheatsheet,
                },
            }
        end,
    },

})
