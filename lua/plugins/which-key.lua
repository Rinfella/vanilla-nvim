-- Which-key configuration

local M = {}

function M.setup()
    local which_key = require("which-key")

    which_key.setup({
        plugins = {
            marks = true,         -- shows marks when pressing '
            registers = true,     -- shows registers when pressing " in NORMAL or <C-r> in INSERT
            spelling = {
                enabled = true,   -- enable if you need spelling suggestions
                suggestions = 20, -- how many suggestions to show
            },
            presets = {
                operators = true,    -- adds help for operators like d, y, ...
                motions = true,      -- adds help for motions
                text_objects = true, -- help for text objects triggered after entering an operator
                windows = true,      -- default bindings on <c-w>
                nav = true,          -- misc bindings to work with windows
                z = true,            -- bindings for folds, spelling, etc. using the z prefix
                g = true,            -- bindings for prefixed with g
            },
        },
        icons = {
            breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
            separator = "➜", -- symbol used between a key and its label
            group = "+", -- symbol prepended to a group
        },
        window = {
            border = "rounded",
            padding = { 2, 2, 2, 2 },
        },
        layout = {
            spacing = 6, -- spacing between columns
        },
        hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "^:", "^ ", "^call ", "^lua " },
        triggers_blacklist = {
            -- list of mode / prefixes that should never be hooked
            i = { "j", "k" },
            v = { "j", "k" },
        },
    })

    -- Register groups
    which_key.register({
        ["<leader>f"] = { name = "+find" },
        ["<leader>b"] = { name = "+buffer" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>s"] = { name = "+scretch" },
        ["<leader>x"] = { name = "+trouble/diagnostics" },
        ["<leader>l"] = { name = "+lsp" },
    })
end

return M
