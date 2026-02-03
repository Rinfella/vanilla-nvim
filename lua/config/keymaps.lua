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
-- No longer conflicts because we moved Obsidian keys
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

-- === Notes (Grouped under <leader>n) ===
-- Consolidated all note taking apps here to clean up keymaps
map("n", "<leader>nn", "<cmd>ObsidianNew<cr>", { desc = "Note: New (Obsidian)" })
map("n", "<leader>ns", "<cmd>Scretch<cr>", { desc = "Note: Scratchpad" })
map("n", "<leader>nf", "<cmd>ObsidianSearch<cr>", { desc = "Note: Find" })
map("n", "<leader>nd", "<cmd>ObsidianToday<cr>", { desc = "Note: Daily" })
map("n", "<leader>nc", "<cmd>Telescope neoclip<cr>", { desc = "Neoclip History" })

-- === Terminal ===
map("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Term Horizontal" })
map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Term Float" })
