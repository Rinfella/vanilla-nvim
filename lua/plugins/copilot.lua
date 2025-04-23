-- copilot.lua
local M = {}

function M.setup()
    require("copilot").setup({
        panel = {
            enabled = false,
            -- auto_refresh = true,
        },
        suggestion = {
            enabled = false,
            -- auto_trigger = false,
            -- debounce = 75,
            -- keymap = {
            --     accept = "<Tab>",
            --     accept_word = "<M-w>",
            --     accept_line = "<M-l>",
            --     next = "<M-]>",
            --     prev = "<M-[>",
            --     dismiss = "<C-]>",
            -- },
        },
        filetypes = {
            ["*"] = true,
        },
    })
end

return M
