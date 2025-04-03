-- Neovim options and settings

-- Leader Key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- System Clipboard
vim.o.clipboard = 'unnamedplus'

-- Line number
vim.o.number = true

-- Relative line number
vim.o.relativenumber = true

-- UI Settings
vim.o.signcolumn = 'yes'
vim.o.termguicolors = true
vim.o.mouse = 'a'

-- Indentation
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true

-- Search Settings
vim.o.ignorecase = true
vim.o.smartcase = true

-- Better split defaults
vim.o.splitright = true
vim.o.splitbelow = true

-- Editor experience
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
vim.o.wrap = true

-- Decrease update time
vim.o.updatetime = 250
