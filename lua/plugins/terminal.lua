-- lua/plugins/terminal.lua
return {
    {
        "akinsho/toggleterm.nvim",
        cmd = "ToggleTerm",
        opts = {
            size = 20,
            open_mapping = [[<c-\>]],
            direction = "float",
        },
    },
    {
        "christoomey/vim-tmux-navigator",
        event = "VeryLazy",
    }
}
