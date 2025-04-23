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
            auto_trigger = true,
            debounce = 75,
            keymap = {
                accept = "<Tab>",
                accept_word = "<M-j>",
                accept_line = "<M-l>",
                next = "<C-]>",
                prev = "<C-[>",
                dismiss = "<C-|",
            },
        },
        filetypes = {
            ["*"] = true,
        },
        copilot_node_command = 'node', -- Node.js version used by Copilot
    })
end

return M
