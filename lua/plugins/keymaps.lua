-- MAP 
local map = vim.keymap.set

-- TODO Keybinds
local todo = require("todo-comments")
map('n', ']t', function()
  todo.jump_next()
end, { desc = "Next todo comment" })

map('n', '[t', function()
  todo.jump_prev()
end, { desc = "Previous todo comment" })

map('n', ']t', function()
  todo.jump_next({keywords = { "ERROR", "WARNING" }})
end, { desc = "Next error/warning todo comment" })

map('n', '<leader>td', '<cmd>TodoTelescope<cr>', { desc = 'Open TODOs finder'})
map('n', '<leader>tl', '<cmd>TodoLocList<cr>', { desc = 'Open TODOs location list'})

-- Move lines of texts
local moveline = require('moveline')
map('n', '<M-k>', moveline.up)
map('n', '<M-j>', moveline.down)
map('v', '<M-k>', moveline.block_up)
map('v', '<M-j>', moveline.block_down)


