-- Neoclip.lua

require('sqlite')
local neoclip = require("neoclip")

neoclip.setup({
    history = 1000,
    enable_persistent_history = true,
    continuous_sync = true,
    db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
    filter = nil,
    preview = true,
    default_register = { '"', "+", "*", "-" },
    default_register_macros = { "q" },
    enable_macro_history = true,
    initial_mode = "normal",
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
    on_custom_action = {
      close_telescope = true,
    },
    keys = {
      telescope = {
        i = {
          select = '<cr>',
          paste = '<a-p>',
          paste_behind = '<a-k>',
          replay = '<c-q>',  -- replay a macro
          delete = '<a-d>',  -- delete an entry
          edit = '<c-e>',  -- edit an entry
          custom = {},
        },
        n = {
          select = '<cr>',
          -- paste = 'p',
          --- It is possible to map to more than one key.
          paste = { 'p', '<a-p>' },
          paste_behind = 'P',
          replay = 'q',
          delete = 'd',
          edit = 'e',
          custom = {},
        },
      },
      fzf = {
        select = 'default',
        paste = 'alt-p',
        paste_behind = 'alt-k',
        custom = {},
      },

    },
})
require('telescope').load_extension('neoclip')


