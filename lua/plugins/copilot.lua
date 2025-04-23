-- copilot.lua
local copilot = require("copilot")

copilot.setup({
    suggestion = { enabled = false },
    panel = { enabled = false },
    filetypes = {
        ["*"] = true,
    },
    suggestion = {
        enabled = true,
        auto_trigger = false,
        hide_during_completion = true,
        debounce = 75,
        trigger_on_accept = true,
        keymap = {
            accept = "<M-l>",
            accept_word = false,
            accept_line = false,
            next = "<M-.>",
            prev = "<M-,>",
            dismiss = "<C-]>",
        },
    },
})
