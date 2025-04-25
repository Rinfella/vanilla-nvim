-- Auto-session plugin configuration
local M = {}

function M.setup()
    require("auto-session").setup({
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
        auto_session_enable_last_session = false,
        auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
        auto_session_enabled = true,
        auto_save_enabled = true,
        auto_restore_enabled = true,
        auto_session_use_git_branch = true,

        -- Customize session name
        pre_save_cmds = {
            function()
                -- Clean up buffers - close help, quickfix, etc.
                for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                    local buftype = vim.api.nvim_buf_get_option(buf, "buftype")
                    if buftype == "help" or buftype == "quickfix" or buftype == "terminal" then
                        vim.api.nvim_buf_delete(buf, { force = true })
                    end
                end
            end
        },
    })

    -- Keymaps
    vim.keymap.set("n", "<leader>Ss", require("auto-session.session-lens").search_session,
        { desc = "Search sessions" })
    vim.keymap.set("n", "<leader>Sd", "<cmd>Autosession delete<CR>", { desc = "Delete session" })
    vim.keymap.set("n", "<leader>Sf", function() require("auto-session").SaveSession() end,
        { desc = "Force save session" })
end

return M
