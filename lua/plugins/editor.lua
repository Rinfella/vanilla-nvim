-- lua/plugins/editor.lua
return {
    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").setup({
                defaults = {
                    file_ignore_patterns = { ".git/", "node_modules", "__pycache__", ".venv" },
                    path_display = { "smart" },
                    mappings = {
                        i = {
                            ["<C-j>"] = "move_selection_next",
                            ["<C-k>"] = "move_selection_previous",
                        },
                    },
                }
            })
        end,
    },

    -- Neo-tree
    {
        "nvim-neo-tree/neo-tree.nvim",
        cmd = "Neotree",
        dependencies = { "MunifTanjim/nui.nvim" },
        opts = {
            window = { width = 30 },
            filesystem = { follow_current_file = { enabled = true } },
        },
    },

    -- Gitsigns
    {
        "lewis6991/gitsigns.nvim",
        event = "BufRead",
        opts = {},
    },

    -- Which-Key
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {},
    },

    -- Autopairs
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    },

    -- Trouble
    {
        "folke/trouble.nvim",
        cmd = "Trouble",
        opts = {},
    },

    -- Harpoon
    {
        "ThePrimeagen/harpoon",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("harpoon").setup({
                menu = { width = 60 },
                terminal = { autoshide = false },
            })
        end,
    }
}
