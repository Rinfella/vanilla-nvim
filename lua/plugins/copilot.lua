-- copilot.lua
local M = {}

function M.setup()
    local opts = {
        panel = { enabled = false },
        suggestion = {
            auto_trigger = true,
            debounce = 75,
            keymap = {
                accept = "<M-a>",
                accept_word = "<M-w>",
                accept_line = "<M-l>",
                next = "<M-]>",
                prev = "<M-[>",
                dismiss = "<M-/",
            },
        },
        filetypes = {
            ["*"] = true,
        },
    }

    require("copilot").setup(opts)
    -- Set up the nvim-cmp and LuaSnip integration
    local cmp = require("cmp")
    local copilot = require("copilot.suggestion")
    local luasnip = require("luasnip")

    local function set_trigger(trigger)
        vim.b.copilot_suggestion_auto_trigger = trigger
        vim.b.copilot_suggestion_hidden = not trigger
    end
    -- Hide suggestions when the completion menu is open
    cmp.event:on("menu_opened", function()
        if copilot.is_visible() then
            copilot.dismiss()
        end
        set_trigger(false)
    end)
    -- Disable suggestions when inside a snippet
    cmp.event:on("menu_closed", function()
        set_trigger(not luasnip.expand_or_locally_jumpable())
    end)
    -- Add autocmd for LuaSnip events
    vim.api.nvim_create_autocmd("User", {
        pattern = { "LuasnipInsertNodeEnter", "LuasnipInsertNodeLeave" },
        callback = function()
            set_trigger(not luasnip.expand_or_locally_jumpable())
        end,
    })
end

return M
