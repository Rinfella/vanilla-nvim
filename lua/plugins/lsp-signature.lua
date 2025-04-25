-- LSP Signature Configuration
local M = {}

function M.setup()
    require("lsp_signature").setup({
        bind = true,
        handler_opts = {
            border = "rounded",
        },
        hint_enable = true,
        hint_prefix = "🐼 ",
        hint_scheme = "String",
        hi_parameter = "Search",
        max_height = 12,
        max_width = 80,
        floating_window = true,
        fix_pos = false,
        always_trigger = false,
        timer_interval = 200,
        doc_lines = 10,
        toggle_key = "<leader>ts",
        select_signature_key = "<C-n>",
        move_cursor_key = "<C-p>",
        zindex = 200,
        transparency = nil,
        shadow_blend = 36,
        shadow_guibg = "Black",
        padding = " ",
        extra_trigger_chars = {},
        close_timeout = 4000,
        floating_window_above_cur_line = true,
        use_lspsaga = false,
    })
end

return M
