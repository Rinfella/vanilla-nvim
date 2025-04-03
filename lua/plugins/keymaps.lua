-- Neotree Keibinds
require("neo-tree").setup({
    window = {
        mappings = {
            ['<cr>'] = "open_with_window_picker",
            ['s'] = "split_with_window_picker",
            ['v'] = "vsplit_with_window_picker",
            ['h'] = "close",
            ['l'] = "open",
        }
    }
})