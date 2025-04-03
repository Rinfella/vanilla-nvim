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

-- TODO Keybinds
vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

-- You can also specify a list of valid jump keywords

vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next({keywords = { "ERROR", "WARNING" }})
end, { desc = "Next error/warning todo comment" })

-- Move lines of texts
local moveline = require('moveline')
vim.keymap.set('n', '<M-k>', moveline.up)
vim.keymap.set('n', '<M-j>', moveline.down)
vim.keymap.set('v', '<M-k>', moveline.block_up)
vim.keymap.set('v', '<M-j>', moveline.block_down)
