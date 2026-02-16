-- Neoclip Clipboard Plugin Configs
return {
    "AckslD/nvim-neoclip.lua",
    event = { "TextYankPost", "VeryLazy" },
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "kkharji/sqlite.lua"
    },
    config = function()
        require("neoclip").setup({
            history = 1000,
            enable_persistent_history = true,
            length_limit = 1048576,
            continuous_sync = true,
            db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
            preview = true,
            default_register = '+',
            default_register_macros = 'q',
            enable_macro_history = true,
            content_spec_column = false,
            on_select = {
                move_to_front = false,
                close_telescope = true,
            },
            on_paste = {
                set_reg = false,
                move_to_front = false,
                close_telescope = true,
            },
            on_replay = {
                set_reg = false,
                move_to_front = false,
                close_telescope = true,
            },
        })
        -- Load the Telescope extension for Neoclip
        require("telescope").load_extension("neoclip")
    end,
}
