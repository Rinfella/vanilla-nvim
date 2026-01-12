local autosave = require("auto-save")

autosave.setup({
	augroup_name = "AutoSavePlug",

	-- The events in which to trigger an auto save.
	events = { "FocusLost", "BufLeave" },
	silent = true,
	save_cmd = nil,

	save_fn = function()
		if vim.bo.buftype == "" and vim.bo.modifiable then
			vim.cmd("silent! update")
		end
	end,

	-- Waits 1 sec after the event to save.
	timeout = 1000,

	exclude_ft = { "neo-tree", "TelescopePrompt", "harpoon" },
})
