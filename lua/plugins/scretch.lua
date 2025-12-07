local scretch = require("scretch")

scretch.setup({
	scretch_dir = vim.fn.stdpath("data") .. "/scretch/", -- will be created if it doesn't exist
	template_dir = vim.fn.stdpath("data") .. "/scretch/templates", -- will be created if it doesn't exist
	default_name = "scretch_",
	default_type = "txt", -- default unnamed Scretches are named "scretch_*.txt"
	split_cmd = "vsplit", -- vim split command used when creating a new Scretch
	backend = "telescope.builtin", -- also accpets "fzf-lua"
})

local map = vim.keymap.set

map("n", "<leader>sn", scretch.new)
map("n", "<leader>snn", scretch.new_named)
map("n", "<leader>sft", scretch.new_from_template)
map("n", "<leader>sl", scretch.last)
map("n", "<leader>ss", scretch.search)
map("n", "<leader>st", scretch.edit_template)
map("n", "<leader>sg", scretch.grep)
map("n", "<leader>sv", scretch.explore)
map("n", "<leader>sat", scretch.save_as_template)
