-- Codeium
local M = {}

function M.setup()
    require("codeium").setup({
        -- Optionally disable cmp source if using virtual text only
        enable_cmp_source = true,
        virtual_text = {
            enabled = true,
            -- Set to true if you never want completions to be shown automatically.
            manual = false,
            -- A mapping of filetype to true or false, to enable virtual text.
            filetypes = {},
            -- Whether to enable virtual text of not for filetypes not specifically listed above.
            default_filetype_enabled = true,
            -- How long to wait (in ms) before requesting completions after typing stops.
            idle_delay = 75,
            -- How long to wait (in ms) before requesting completions after typing stops.
            fetching_timeout = 100,
            -- other plugins that also add virtual text, such as LSP inlay hints, but can be modified if
            -- desired.
            virtual_text_priority = 65535,
            -- Set to false to disable all key bindings for managing completions.
            map_keys = true,
            -- The key to press when hitting the accept keybinding but no completion is showing.
            -- Defaults to \t normally or <c-n> when a popup is showing.
            accept_fallback = nil,
            accept = "<C-f>",
            -- Key bindings for managing completions in virtual text mode.
            key_bindings = {
                -- Accept the current completion.
                accept = "<Tab>",
                -- Accept the next word.
                accept_word = false,
                -- Accept the next line.
                accept_line = false,
                -- Clear the virtual text.
                clear = false,
                -- Cycle to the next completion.
                next = "<M-]>",
                -- Cycle to the previous completion.
                prev = "<M-[>",
            }
        }
    })

    require('codeium.virtual_text').set_statusbar_refresh(function()
        require('lualine').refresh()
    end)
end

return M
