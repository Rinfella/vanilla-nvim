-- Harpoon Configuration
local M = {}

function M.setup()
    require("harpoon").setup({
        menu = {
            width = math.floor(vim.api.nvim_win_get_width(0) * 0.6),
            height = math.floor(vim.api.nvim_win_get_height(0) * 0.6),
        },
        save_on_change = true,
        save_on_toggle = false,
        enter_on_sendcmd = false,
        tmux_autoclose_windows = false,
        excluded_filetypes = { "harpoon" },
        mark_branch = false,


    })
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")
    local ts = require("telescope")

    local map = vim.keymap.set

    map("n", "<leader>ha", mark.add_file, { desc = "Add to Harpoon" })

    -- Navigate through marks
    map("n", "<leader>hm", function() ts.extensions.harpoon.marks() end, { desc = "Telescope Harpoon marks" })
    map("n", "<leader>hh", ui.toggle_quick_menu, { desc = "Harpoon Menu" })
    map("n", "<C-n>", ui.nav_next, { desc = "Next Harpoon mark" })
    map("n", "<C-p>", ui.nav_prev, { desc = "Prev Harpoon mark" })

    -- Shortcuts for navigating to specific marks
    map("n", "<leader>1", function() ui.nav_file(1) end, { desc = "Harpoon buffer 1" })
    map("n", "<leader>2", function() ui.nav_file(2) end, { desc = "Harpoon buffer 2" })
    map("n", "<leader>3", function() ui.nav_file(3) end, { desc = "Harpoon buffer 3" })
    map("n", "<leader>4", function() ui.nav_file(4) end, { desc = "Harpoon buffer 4" })
    map("n", "<leader>5", function() ui.nav_file(5) end, { desc = "Harpoon buffer 5" })
end

return M
