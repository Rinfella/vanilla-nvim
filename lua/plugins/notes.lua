-- lua/plugins/notes.lua
return {
    -- Obsidian
    {
        "obsidian-nvim/obsidian.nvim",
        ft = "markdown",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            workspaces = {
                { name = "notes", path = "~/Documents/notes" },
            },
        },
    },

    -- Render Markdown
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = "markdown",
        opts = {},
    },

    -- Scretch (Your custom notes)
    {
        "0xJohnnyboy/scretch.nvim",
        cmd = "Scretch",
        opts = {},
    },

    -- Cheatsheet
    {
        "doctorfree/cheatsheet.nvim",
        cmd = "Cheatsheet",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
    }
}
