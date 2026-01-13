-- Neovim options and settings

-- Leader Key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- System Clipboard
vim.o.clipboard = "unnamedplus"

-- Line number
vim.o.number = true

-- Relative line number
vim.o.relativenumber = true

-- UI Settings
vim.o.signcolumn = "yes"
vim.o.termguicolors = true
vim.o.mouse = "a"

-- Folding
vim.o.foldenable = true
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldnestmax = 3

-- Indentation
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true

-- Search Settings
vim.o.ignorecase = true
vim.o.smartcase = true

-- Save undo history to a file
vim.o.undofile = true
vim.o.undodir = vim.fn.stdpath("data") .. "/undo"

-- Better split defaults
vim.o.splitright = true
vim.o.splitbelow = true

-- Editor experience
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
vim.o.wrap = true

-- Decrease update time
vim.o.updatetime = 300

vim.g.loaded_python3_provider = 0 -- Disable Python
vim.g.loaded_ruby_provider = 0 -- Disable Ruby
vim.g.loaded_perl_provider = 0 -- Disable Perl
vim.g.loaded_node_provider = 0 -- Disable Node

-- GUI Cursor for vscode (tul lo ltkk)
vim.opt.guicursor = {
	"n-v-c:block",
	"i-ci:ver25",
	"r-cr:hor20",
	"o:hor50",
	"a:blinkwait700-blinkoff400-blinkon250",
}
-- Disable unused builtin plugins
local disabled_built_ins = {
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"gzip",
	"zip",
	"zipPlugin",
	"tar",
	"tarPlugin",
	"getscript",
	"getscriptPlugin",
	"vimball",
	"vimballPlugin",
	"2html_plugin",
	"logipat",
	"rrhelper",
	"spellfile_plugin",
}

for _, plugin in pairs(disabled_built_ins) do
	vim.g["loaded_" .. plugin] = 1
end
