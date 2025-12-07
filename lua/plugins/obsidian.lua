local client = require("obsidian").setup({
	-- Log level for obsidian.nvim
	log_level = vim.log.levels.INFO,

	-- Disable legacy commands to avoid deprecation warnings
	legacy_commands = false,

	-- Define workspaces (better than single dir for flexibility)
	workspaces = {
		{
			name = "main",
			path = "~/Documents/obsidian-notes",
			-- Override certain settings for this workspace
			overrides = {
				notes_subdir = "notes",
			},
		},
	},

	-- Specific dir for notes (optional)
	notes_subdir = "notes",

	-- Daily notes config
	daily_notes = {
		folder = "notes/daily-notes",
		date_format = "%Y-%m-%d", -- Better format for sorting
		alias_format = "%B %-d, %Y",
		default_tags = { "daily-notes" },
		template = "templates/daily-notes.md",
		workdays_only = false, -- Set to false for more flexibility
	},

	-- Enhanced completion settings
	completion = {
		nvim_cmp = true,
		blink = false,
		min_chars = 2,
		create_new = true,
	},

	-- Location for new notes
	new_notes_location = "notes_subdir",

	-- Enhanced note ID function with your preferred timestamp format
	note_id_func = function(title)
		local timestamp = os.date("%Y%m%d-%H%M%S")
		if title ~= nil then
			-- Convert title to slug and append timestamp
			local clean_title = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
			return clean_title .. "-" .. timestamp
		else
			return "note-" .. timestamp
		end
	end,

	-- Enhanced note path function
	note_path_func = function(spec)
		local path = spec.dir / tostring(spec.id)
		return path:with_suffix(".md")
	end,

	-- Wiki link formatting
	wiki_link_func = function(opts)
		return require("obsidian.util").wiki_link_id_prefix(opts)
	end,

	-- Markdown link formatting
	markdown_link_func = function(opts)
		return require("obsidian.util").markdown_link(opts)
	end,

	-- Preferred link style
	preferred_link_style = "wiki",

	-- Frontmatter management
	disable_frontmatter = false,

	-- Enhanced frontmatter function
	note_frontmatter_func = function(note)
		local frontmatter = {
			id = note.id,
			aliases = note.aliases,
			tags = note.tags,
			created = os.date("%Y-%m-%d %H:%M:%S"),
			modified = os.date("%Y-%m-%d %H:%M:%S"),
		}

		if note.title then
			note:add_alias(note.title)
			frontmatter.title = note.title
		end

		-- Preserve existing metadata
		if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
			for k, v in pairs(note.metadata) do
				frontmatter[k] = v
			end
		end

		return frontmatter
	end,

	-- Enhanced templates configuration
	templates = {
		folder = "templates",
		date_format = "%Y-%m-%d",
		time_format = "%H:%M",
		-- Custom template variables
		substitutions = {
			["current_date"] = function()
				return os.date("%Y-%m-%d")
			end,
			["current_time"] = function()
				return os.date("%H:%M")
			end,
			["current_datetime"] = function()
				return os.date("%Y-%m-%d %H:%M:%S")
			end,
			["yesterday"] = function()
				return os.date("%Y-%m-%d", os.time() - 86400)
			end,
			["tomorrow"] = function()
				return os.date("%Y-%m-%d", os.time() + 86400)
			end,
		},
	},

	-- URL and image handling
	follow_url_func = function(url)
		vim.ui.open(url)
	end,

	follow_img_func = function(img)
		vim.ui.open(img)
	end,

	-- Open configuration
	open = {
		use_advanced_uri = false,
		func = vim.ui.open,
	},

	-- Picker configuration
	picker = {
		name = "telescope.nvim",
		note_mappings = {
			new = "<C-x>",
			insert_link = "<C-l>",
		},
		tag_mappings = {
			tag_note = "<C-x>",
			insert_tag = "<C-l>",
		},
	},

	-- Backlinks configuration
	backlinks = {
		parse_headers = true,
	},

	-- Search and sorting
	sort_by = "modified",
	sort_reversed = true,
	search_max_lines = 1000,

	-- Window management
	open_notes_in = "current",

	-- Enhanced UI configuration
	ui = {
		enable = true,
		ignore_conceal_warn = false,
		update_debounce = 200,
		max_file_length = 5000,

		-- Enhanced checkboxes (UI rendering only - NOT for toggle order)
		checkboxes = {
			[" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
			["x"] = { char = "", hl_group = "ObsidianDone" },
			[">"] = { char = "", hl_group = "ObsidianRightArrow" },
			["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
			["!"] = { char = "", hl_group = "ObsidianImportant" },
			["-"] = { char = "", hl_group = "ObsidianCancelled" },
			["/"] = { char = "󰤕", hl_group = "ObsidianInProgress" },
		},

		bullets = { char = "•", hl_group = "ObsidianBullet" },
		external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
		reference_text = { hl_group = "ObsidianRefText" },
		highlight_text = { hl_group = "ObsidianHighlightText" },
		tags = { hl_group = "ObsidianTag" },
		block_ids = { hl_group = "ObsidianBlockID" },

		-- Enhanced highlighting groups
		hl_groups = {
			ObsidianTodo = { bold = true, fg = "#f78c6c" },
			ObsidianDone = { bold = true, fg = "#89ddff" },
			ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
			ObsidianTilde = { bold = true, fg = "#ff5370" },
			ObsidianImportant = { bold = true, fg = "#d73128" },
			ObsidianCancelled = { bold = true, fg = "#696969" },
			ObsidianInProgress = { bold = true, fg = "#ffcb6b" },
			ObsidianBullet = { bold = true, fg = "#89ddff" },
			ObsidianRefText = { underline = true, fg = "#c792ea" },
			ObsidianExtLinkIcon = { fg = "#c792ea" },
			ObsidianTag = { italic = true, fg = "#89ddff" },
			ObsidianBlockID = { italic = true, fg = "#89ddff" },
			ObsidianHighlightText = { bg = "#75662e" },
		},
	},

	-- Enhanced attachments configuration
	attachments = {
		img_folder = "assets/imgs",
		img_name_func = function()
			return string.format("img-%s", os.date("%Y%m%d-%H%M%S"))
		end,
		confirm_img_paste = true,
	},

	-- Footer configuration (replaces deprecated statusline)
	footer = {
		enabled = true,
		format = "{{backlinks}} backlinks  {{properties}} properties  {{words}} words  {{chars}} chars",
		hl_group = "Comment",
		separator = string.rep("─", 80),
	},

	-- IMPORTANT: Use checkbox.order instead of ui.checkboxes for toggle order
	-- This controls the order when cycling through checkboxes with toggle commands
	checkbox = {
		order = { " ", "~", "!", "/", "-", ">", "x" }, -- Custom order for checkbox cycling
	},

	-- Enhanced callbacks for custom behavior
	callbacks = {
		post_setup = function(client)
			-- Custom setup after obsidian.nvim initialization
		end,

		enter_note = function(client, note)
			-- Automatically set conceallevel for better viewing
			vim.wo.conceallevel = 2
		end,

		leave_note = function(client, note)
			-- Reset conceallevel when leaving note
			vim.wo.conceallevel = 0
		end,

		pre_write_note = function(client, note)
			-- Update modification time before saving
			if note.metadata then
				note.metadata.modified = os.date("%Y-%m-%d %H:%M:%S")
			end
		end,
	},
})

-- Custom note creation function for advanced workflows
local function create_note_with_template(subdir, ask_name, template)
	local fname = ""

	if ask_name then
		local input = vim.fn.input("Note title: ", "")
		if input == "" then
			return
		end
		fname = input
	else
		fname = os.date("%Y%m%d-%H%M%S")
	end

	local query = fname .. ".md"
	if subdir then
		query = subdir .. "/" .. fname .. ".md"
	end

	local note = client:resolve_note(query)
	if note == nil then
		note = client:new_note(fname, fname, client.dir .. "/" .. (subdir or ""))
	end

	-- Open in vertical split
	vim.cmd("vsplit")
	vim.cmd("edit " .. tostring(note.path))

	-- Apply template if specified
	if template then
		vim.cmd("Obsidian template " .. template)
	end
end

-- Enhanced keybindings with NEW COMMAND SYNTAX (no legacy commands)
local function setup_obsidian_keymaps()
	local opts = { noremap = true, silent = true }

	-- Navigation and basic commands (NEW SYNTAX - no legacy commands)
	vim.keymap.set("n", "<leader>on", "<cmd>Obsidian new<cr>", { desc = "Create new note", unpack(opts) })
	vim.keymap.set("n", "<leader>oo", "<cmd>Obsidian search<cr>", { desc = "Search notes", unpack(opts) })
	vim.keymap.set("n", "<leader>oq", "<cmd>Obsidian quick_switch<cr>", { desc = "Quick switch notes", unpack(opts) })
	vim.keymap.set("n", "<leader>ob", "<cmd>Obsidian backlinks<cr>", { desc = "Show backlinks", unpack(opts) })
	vim.keymap.set("n", "<leader>ot", "<cmd>Obsidian tags<cr>", { desc = "Search by tags", unpack(opts) })

	-- Daily notes
	vim.keymap.set("n", "<leader>od", "<cmd>Obsidian today<cr>", { desc = "Open today's note", unpack(opts) })
	vim.keymap.set("n", "<leader>oy", "<cmd>Obsidian yesterday<cr>", { desc = "Open yesterday's note", unpack(opts) })
	vim.keymap.set("n", "<leader>ot", "<cmd>Obsidian tomorrow<cr>", { desc = "Open tomorrow's note", unpack(opts) })

	-- Templates
	vim.keymap.set("n", "<leader>oT", "<cmd>Obsidian template<cr>", { desc = "Insert template", unpack(opts) })

	-- Navigation
	vim.keymap.set("n", "gf", "<cmd>Obsidian follow_link<cr>", { desc = "Follow link under cursor", unpack(opts) })
	vim.keymap.set("n", "<leader>ol", "<cmd>Obsidian links<cr>", { desc = "Show all links in note", unpack(opts) })
	vim.keymap.set("n", "<leader>oc", "<cmd>Obsidian toc<cr>", { desc = "Table of contents", unpack(opts) })

	-- Workspace management
	vim.keymap.set("n", "<leader>ow", "<cmd>Obsidian workspace<cr>", { desc = "Switch workspace", unpack(opts) })
	vim.keymap.set("n", "<leader>oO", "<cmd>Obsidian open<cr>", { desc = "Open in Obsidian app", unpack(opts) })

	-- Custom note creation functions
	vim.keymap.set("n", "<leader>nc", function()
		create_note_with_template("capture", false, nil)
	end, { desc = "Quick capture note", unpack(opts) })

	vim.keymap.set("n", "<leader>np", function()
		create_note_with_template("projects", true, "project")
	end, { desc = "New project note", unpack(opts) })

	vim.keymap.set("n", "<leader>nb", function()
		create_note_with_template("blog", true, "blog")
	end, { desc = "New blog post", unpack(opts) })

	-- Link creation in visual mode
	vim.keymap.set("v", "<leader>ol", "<cmd>Obsidian link<cr>", { desc = "Link selection", unpack(opts) })
	vim.keymap.set("v", "<leader>on", "<cmd>Obsidian link_new<cr>", { desc = "Link to new note", unpack(opts) })
	vim.keymap.set("v", "<leader>ox", "<cmd>Obsidian extract_note<cr>", { desc = "Extract to new note", unpack(opts) })

	-- Utility commands
	vim.keymap.set("n", "<leader>or", "<cmd>Obsidian rename<cr>", { desc = "Rename note", unpack(opts) })
	vim.keymap.set("n", "<leader>op", "<cmd>Obsidian paste_img<cr>", { desc = "Paste image", unpack(opts) })
	vim.keymap.set("n", "<leader>ox", "<cmd>Obsidian toggle_checkbox<cr>", { desc = "Toggle checkbox", unpack(opts) })

	-- Smart actions
	vim.keymap.set("n", "<cr>", function()
		if require("obsidian").util.cursor_on_markdown_link() then
			return "<cmd>Obsidian follow_link<cr>"
		else
			return "<cr>"
		end
	end, { expr = true, desc = "Smart follow link" })
end

-- Setup keymaps
setup_obsidian_keymaps()

return client
