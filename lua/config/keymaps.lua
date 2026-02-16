-- lua/config/keymaps.lua
local map = vim.keymap.set

-- === Core ===
map("n", "<leader>w", "<cmd>write<cr>", { desc = "Save" })
map("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit" })
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear Highlight" })

-- === Navigation ===
map("n", "<C-h>", "<C-w>h", { desc = "Window Left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window Down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window Up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window Right" })

-- === Editor Tools ===
map("n", "<leader>e", "<cmd>Neotree reveal<cr>", { desc = "Explorer Reveal" })
map("n", "<leader>o", "<cmd>Neotree toggle<cr>", { desc = "Explorer Toggle" })

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help" })

-- Git
map("n", "<leader>gg", "<cmd>Lazygit<cr>", { desc = "Lazygit" })
map("n", "<leader>gb", "<cmd>Gitsigns blame_line<cr>", { desc = "Blame Line" })

-- Trouble (Diagnostics)
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf<cr>", { desc = "Buffer Diagnostics (Trouble)" })
map("n", "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
map("n", "<leader>xl", "<cmd>Trouble lsp toggle focus=false<cr>", { desc = "LSP (Trouble)" })
map("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })
map("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })

-- === 99 (AI Agent) ===
map("n", "<leader>9f", function() require("99").fill_in_function() end, { desc = "99: Fill Function" })
map("n", "<leader>9F", function() require("99").fill_in_function_prompt() end, { desc = "99: Fill Function (Prompt)" })
map("v", "<leader>9v", function() require("99").visual() end, { desc = "99: Visual Selection" })
map("v", "<leader>9V", function() require("99").visual_prompt() end, { desc = "99: Visual (Prompt)" })
map("n", "<leader>9s", function() require("99").stop_all_requests() end, { desc = "99: Stop Requests" })
map("n", "<leader>9l", function() require("99").view_logs() end, { desc = "99: View Logs" })

-- === Notes (Grouped under <leader>n) ===
-- Obsidian
map("n", "<leader>nn", "<cmd>Obsidian new<cr>", { desc = "Obsidian: New Note" })
map("n", "<leader>nf", "<cmd>Obsidian search<cr>", { desc = "Obsidian: Find Note" })
map("n", "<leader>nd", "<cmd>Obsidian today<cr>", { desc = "Obsidian: Daily Note" })
map("n", "<leader>ny", "<cmd>Obsidian yesterday<cr>", { desc = "Obsidian: Yesterday" })
map("n", "<leader>nm", "<cmd>Obsidian tomorrow<cr>", { desc = "Obsidian: Tomorrow" })
-- Show backlinks (what links to this note?) - Crucial for Zettelkasten
map("n", "<leader>nb", "<cmd>Obsidian backlinks<cr>", { desc = "Obsidian: Backlinks" })
-- Show outgoing links (what does this note link to?)
map("n", "<leader>nl", "<cmd>Obsidian links<cr>", { desc = "Obsidian: Outgoing Links" })
-- Open the current note in the actual Obsidian App
map("n", "<leader>no", "<cmd>Obsidian open<cr>", { desc = "Obsidian: Open in App" })
map("n", "<leader>ng", "<cmd>Obsidian tags<cr>", { desc = "Obsidian: Search Tags" })
-- Toggle Checkbox (cycles [ ] -> [x] -> [-])
map("n", "<leader>nc", "<cmd>ObsidianToggleCheckbox<cr>", { desc = "Obsidian: Toggle Checkbox" })
-- Extract selected text to a new note
map("v", "<leader>nx", "<cmd>ObsidianExtractNote<cr>", { desc = "Obsidian: Extract Selection" })

-- Scretch (Scratchpad)
map("n", "<leader>ns", "<cmd>Scretch<cr>", { desc = "Scretch: New" })
map("n", "<leader>nS", "<cmd>Scretch new_named<cr>", { desc = "Scretch: New Named" })
map("n", "<leader>nl", "<cmd>Scretch last<cr>", { desc = "Scretch: Open Last" })
map("n", "<leader>nF", "<cmd>Scretch search<cr>", { desc = "Scretch: Find (Telescope)" })
map("n", "<leader>nG", "<cmd>Scretch grep<cr>", { desc = "Scretch: Grep (Telescope)" })

-- Neoclip History
map("n", "<leader>nc", "<cmd>Telescope neoclip initial_mode=normal<cr>", { desc = "Neoclip History" })

-- === Terminal ===
map("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Term Horizontal" })
map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Term Float" })

-- === Copilot ===
map("i", "<A-a>", function() require("copilot.suggestion").accept() end, { desc = "Copilot: Accept Block" })
map("i", "<A-l>", function() require("copilot.suggestion").accept_line() end, { desc = "Copilot: Accept Line" })
map("i", "<A-w>", function() require("copilot.suggestion").accept_word() end, { desc = "Copilot: Accept Word" })
