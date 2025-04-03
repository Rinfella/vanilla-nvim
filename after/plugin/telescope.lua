-- after/plugin/telescope/lua

require('telescope').setup({
	extensions = {
		fzf = {
			fuzzy = true, 							-- false will match only exact words
			override_generic_sorter = true, 		-- overrides the generic sorter
			override_file_sorter = true,			-- overrides the file sorter
			case_mode = "smart_case", 				-- "ignore_case" OR "respect_case" available. "smart_case" is the default.
		}
	}
})

require('telescope').load_extension('fzf')
