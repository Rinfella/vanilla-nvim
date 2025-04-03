-- Plugin Management using lazy.nvim

-- Bootstrap lazy.nvim if it does not exist
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"git@github.com:folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Load Plugins
require("lazy").setup({
	-- Core plugins
	-- Mason + LSP
	{
		"williamboman/mason.nvim",
		event = "VeryLazy",
	},

	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
		},


		config = function()
		require("plugins.lsp")
		end,
	},

"folke/neodev.nvim",

	-- Comments
	{
		"numToStr/Comment.nvim",
		 event = "VeryLazy",
		 config = function() require("Comment").setup() end
	},

	-- Theme and UI
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("plugins.ui")
		end,
	},

	-- Status Line
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons"
		},
	},
	
	-- Completion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
		      "L3MON4D3/LuaSnip",
		      "saadparwaiz1/cmp_luasnip",
		      "rafamadriz/friendly-snippets",
		      "hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			require("plugins.cmp")
		end,
	},
	
	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			}
		},
		config = function()
			require("plugins.telescope")
		end,
	},

	-- Tree Sitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function ()
			require("plugins.treesitter")
		end,
	},

	-- File Esplorer (Neotree)
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		cmd = "Neotree",
		keys = {
			{ "<leader>e", "<cmd>Neotree reveal<cr>", desc = "Explorer" },
		},
		config = function()
			require("core.keymaps")
			require("neo-tree").setup({
				close_if_last_window = false,
				popup_border_style = "rounded",
				enable_git_status = true,
				enable_diagnostics = true,
				open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
				sort_case_insensitive = false,
				filesystem = {
					filtered_items = {
						visible = false,
						hide_dotfiles = true,
						hide_gitignored = true,
						hide_hidden = true,
					},
					follow_current_file = {
						enabled = true,
					},
					hijack_netrw_behavior = "open_default",
				},
				window = {
					position = "left",
					width = 40,
				},
			})
		end,
	},
})

