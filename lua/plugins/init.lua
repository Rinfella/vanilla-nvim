--  Plugin Management using lazy.nvim

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
        cmd = "Mason",
        config = function()
            require("mason").setup({
                ui = {
                    border = "rounded",
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })
        end,
    },

    {
        "williamboman/mason-lspconfig.nvim",
        event = "BufReadPre",
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
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {},
    },


    -- Comments toggle
    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        config = function() require("Comment").setup() end
    },

    -- Colorizer
    {
        "norcalli/nvim-colorizer.lua",
        event = "VeryLazy",
        config = function()
            require("colorizer").setup()
        end,
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
        event = "VimEnter",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("plugins.dashboard")
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
        event = { "InsertEnter", "CmdlineEnter" },
        dependencies = {
            "L3MON4D3/LuaSnip",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
            "dnnr1/lorem-ipsum.nvim",
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

    -- Codeium
    {
        "Exafunction/windsurf.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
        },
        config = function()
            require("codeium").setup()
        end
    },

    -- Neoclip
    {
        "AckslD/nvim-neoclip.lua",
        dependencies = {
            { "nvim-telescope/telescope.nvim" },
            { 'kkharji/sqlite.lua',           module = 'sqlite' },
        },
        config = function()
            require("plugins.neoclip")
        end,
    },

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

    -- Telescope file explorer
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        config = function()
            require("telescope").load_extension("file_browser")
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

    -- AUTOPAIRS
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true
        -- use opts = {} for passing setup options
        -- this is equivalent to setup({}) function
    },

    -- WHICHKEY
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            require("plugins.which-key")
        end,
    },

    -- GITSIGNS
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("plugins.git")
        end,
    },

    -- INDENT BLANKLINE
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPost", "BufNewFile" },
        main = "ibl",
        config = function()
            require("plugins.indent").setup()
        end,
    },

    -- TOGGLETERM
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        cmd = { "ToggleTerm", "TermExec" },
        keys = { "<C-\\>", "<leader>tf", "<leader>th", "<leader>tv" },
        config = function()
            require("plugins.terminal").setup()
        end,
    },

    -- NOICE
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        config = function()
            require("plugins.noice")
        end,
    },

    -- LSP SIGNATURE
    {
        "ray-x/lsp_signature.nvim",
        event = "LspAttach",
        config = function()
            require("plugins.lsp-signature").setup()
        end,
    },

    -- HARPOON
    {
        "ThePrimeagen/harpoon",
        branch = "master",
        dependencies = { "nvim-lua/plenary.nvim" },
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("telescope").load_extension("harpoon")
            require("plugins.harpoon").setup()
        end,
    },

    -- AUTO SESSION
    {
        "rmagatti/auto-session",
        cmd = { "SessionSave", "SessionRestore", "SessionDelete", "Autosession" },
        keys = { "<leader>Ss", "<leader>Sd", "<leader>Sf" },
        config = function()
            require("plugins.session")
        end,
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
            require("plugins.cheatsheet")
        end,
    },
})
