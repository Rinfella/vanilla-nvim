-- lua/plugins/notes.lua
return {
    -- Obsidian
    {
        "obsidian-nvim/obsidian.nvim",
        version = "*",
        lazy = true,
        cmd = "Obsidian",
        ft = "markdown",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            workspaces = {
                {
                    name = "notes",
                    path = vim.fn.expand("~/Documents/obsidian-notes"),
                },
            },
            ui = { enable = false }, -- Optional: clean UI
            daily_notes = {
                folder = "notes/daily-notes",
                date_format = "%Y-%m-%d",
            },

            completion = { nvim_cmp = true },

            legacy_commands = false,
        },
    },

    -- Render Markdown
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = "markdown",
        opts = {},
    },

    -- Scretch
    {
        "0xJohnnyboy/scretch.nvim",
        cmd = "Scretch",
        opts = {
            scretch_dir = vim.fn.stdpath("data") .. "/scretch",
        },
    },

    -- Cheatsheet
    {
        "doctorfree/cheatsheet.nvim",
        cmd = "Cheatsheet",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
    },

    -- Auto Session
    {
        "rmagatti/auto-session",
        config = function()
            require("auto-session").setup({
                suppress_dirs = { "~/", "~/projects", "~/Downloads", "/" },
            })
        end,
    }
}
