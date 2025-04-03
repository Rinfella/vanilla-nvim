-- after/plugin/treesitter.lua

require('nvim-treesitter.configs').setup {
	ensure_installed = {
		'vim',
		'vimdoc',
		'lua',
		'cpp',
		'php',
		'go'
	},

	auto_install = true,

	highlight = { enable = true },

	indent = { enable = true },
}
