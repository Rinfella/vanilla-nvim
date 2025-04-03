-- Keymaps for Neovim
-- Leader key is already set to space in options.lua

local map = vim.keymap.set

-- General keymaps
map('n', '<leader>w', '<cmd>write<cr>', { desc = 'Save' })
map('n', '<leader>q', '<cmd>quit<cr>', { desc = 'Quit' })

-- Clear search highlight with ESC
map('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })

-- Better window navigation
map('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
map('n', '<C-j>', '<C-w>j', { desc = 'Move to below window' })
map('n', '<C-k>', '<C-w>k', { desc = 'Move to above window' })
map('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })

-- Resize with arrows
map('n', '<C-Up>', '<cmd>resize -2<cr>', { desc = 'Resize window up' })
map('n', '<C-Down>', '<cmd>resize +2<cr>', { desc = 'Resize window down' })
map('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Resize window left' })
map('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Resize window right' })

-- Better movement
map('n', 'J', 'mzJ`z', { desc = 'Join lines keeping cursor position' })
map('n', '<C-d>', '<C-d>zz', { desc = 'Move down half-page keeping cursor centered' })
map('n', '<C-u>', '<C-u>zz', { desc = 'Move up half-page keeping cursor centered' })
map('n', 'n', 'nzzzv', { desc = 'Next search result keeping cursor centered' })
map('n', 'N', 'Nzzzv', { desc = 'Previous search result keeping cursor centered' })

-- Move lines in visual mode
map('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selected line down' })
map('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selected line up' })

-- Open Neotree
map('n', '<leader>e', '<cmd>Neotree reveal<CR>', { desc = 'Open file explorer' })
map('n', '<leader>o', '<cmd>Neotree toggle<CR>', { desc = 'Toggle file explorer' })

-- Telescope
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Find files' })
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', { desc = 'Find text' })
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', { desc = 'Find buffers' })
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', { desc = 'Find help' })

-- TODO
map('n', '<leader>td', '<cmd>TodoTelescope<cr>', { desc = 'Open TODOs finder'})
map('n', '<leader>tl', '<cmd>TodoLocList<cr>', { desc = 'Open TODOs location list'})

-- The mapping for LSP will be defined in plugins/lsp.lua as they're directly related to LSP functionality


