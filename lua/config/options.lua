-- lua/config/options.lua
local opt = vim.opt

-- General
vim.g.mapleader = " "
vim.g.maplocalleader = " "
opt.clipboard = "unnamedplus"
opt.termguicolors = true
opt.mouse = "a"
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undo"

-- Performance
opt.synmaxcol = 240
opt.updatetime = 50
opt.cursorline = true

-- Native Treesitter (Neovim 0.12+)
-- Syntax highlighting enabled by default in 0.12+

-- Numbers and Signs
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"

-- Formatting
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.wrap = true
opt.scrolloff = 8

-- Search
opt.ignorecase = true
opt.smartcase = true

-- UI Tweaks
opt.splitright = true
opt.splitbelow = true
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Disable unused providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
