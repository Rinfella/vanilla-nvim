-- copilot.lua
local M = {}

function M.setup()
    require("copilot").setup({
        panel = {
            enabled = true,
            auto_refresh = true,
        },
        suggestion = {
            enabled = true,
            auto_trigger = false,
            debounce = 75,
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
        copilot_node_command = 'node', -- Node.js version used by Copilot
    })
end

return M
