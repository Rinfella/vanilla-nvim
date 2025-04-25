-- Illuminate config

local M = {}

function M.setup()
    require("illuminate").configure({
        providers = {
            "lsp",
            "treesitter",
            "regex",
        },
        delay = 100,
        under_cursor = true,
        min_count_to_highlight = 2,
        filetypes_denylist = {
            "alpha",
            "NvimTree",
            "neo-tree",
            "dashboard",
            "TelescopePrompt",
            "help",
            "lazy",
            "mason",
            "notify",
            "toggleterm",
            "lazyterm",
        },
    })

    -- Change the highlight style
    local set = vim.api.nvim_set_hl
    set(0, "IlluminatedWordText", { link = "Visual" })
    set(0, "IlluminatedWordRead", { link = "Visual" })
    set(0, "IlluminatedWordWrite", { link = "Visual" })

    -- Keymaps for navigation between illuminated words
    local map = vim.keymap.set
    map("n", "]]", function() require("illuminate").goto_next_reference() end, { desc = "Next Reference" })
    map("n", "[[", function() require("illuminate").goto_prev_reference() end, { desc = "Prev Reference" })
end

return M
