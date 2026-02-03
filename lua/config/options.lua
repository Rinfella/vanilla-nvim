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
opt.list = true -- Replaces indent-blankline basic functionality
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Disable unused providers
vim.g.loaded_python3_provider = 0 -- Disable Python
vim.g.loaded_ruby_provider = 0    -- Disable Ruby
vim.g.loaded_perl_provider = 0    -- Disable Perl
vim.g.loaded_node_provider = 0    -- Disable Node
