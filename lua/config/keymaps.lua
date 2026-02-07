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

-- === Notes (Grouped under <leader>n) ===
-- Obsidian
map("n", "<leader>nn", "<cmd>Obsidian new<cr>", { desc = "Obsidian: New Note" })
map("n", "<leader>nf", "<cmd>Obsidian search<cr>", { desc = "Obsidian: Find Note" })
map("n", "<leader>nd", "<cmd>Obsidian today<cr>", { desc = "Obsidian: Daily Note" })

-- Scretch (Scratchpad)
map("n", "<leader>ns", "<cmd>Scretch<cr>", { desc = "Scretch: New" })
map("n", "<leader>nS", "<cmd>Scretch new_named<cr>", { desc = "Scretch: New Named" })
map("n", "<leader>nl", "<cmd>Scretch last<cr>", { desc = "Scretch: Open Last" })
map("n", "<leader>nF", "<cmd>Scretch search<cr>", { desc = "Scretch: Find (Telescope)" })
map("n", "<leader>nG", "<cmd>Scretch grep<cr>", { desc = "Scretch: Grep (Telescope)" })

-- Neoclip History
map("n", "<leader>nc", "<cmd>Telescope neoclip<cr>", { desc = "Neoclip History" })

-- === Terminal ===
map("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Term Horizontal" })
map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Term Float" })
