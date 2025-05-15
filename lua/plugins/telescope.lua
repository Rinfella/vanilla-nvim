-- Telescope configuration

local telescope = require("telescope")

telescope.setup({
    defaults = {
        initial_mode = "normal",
        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart" },
        file_ignore_patterns = { ".git/", "node_modules", "target", "build" },
        mappings = {
            i = {
                ['<C-j>'] = "move_selection_next",
                ['<C-k>'] = "move_selection_previous",
            },
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        }
    }
})

-- Load FZF native extension
telescope.load_extension("fzf")
