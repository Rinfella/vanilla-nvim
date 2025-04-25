-- GIT Signs Config

local M = {}

function M.setup()
    require("gitsigns").setup({
        signs = {
            add = { text = "│" },
            change = { text = "│" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
            untracked = { text = "┆" },
        },
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        watch_gitdir = {
            follow_files = true,
        },
        auto_attach = true,
        attach_to_untracked = true,
        current_line_blame = false,
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = "eol",
            delay = 1000,
            ignore_whitespace = false,
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        preview_config = {
            border = "rounded",
            style = "minimal",
            relative = "cursor",
            row = 0,
            col = 1,
        },
        yadm = { enable = false },
        on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            -- Navigation
            vim.keymap.set("n", "]c", function()
                if vim.wo.diff then
                    return "]c"
                end
                vim.schedule(function()
                    gs.next_hunk()
                end)
                return "<Ignore>"
            end, { expr = true, buffer = bufnr, desc = "Next hunk" })

            vim.keymap.set("n", "[c", function()
                if vim.wo.diff then
                    return "[c"
                end
                vim.schedule(function()
                    gs.prev_hunk()
                end)
                return "<Ignore>"
            end, { expr = true, buffer = bufnr, desc = "Previous hunk" })

            -- Actions
            local map = vim.keymap.set

            map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", { buffer = bufnr, desc = "Stage hunk" })
            map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", { buffer = bufnr, desc = "Reset hunk" })
            map("n", "<leader>Gu", gs.undo_stage_hunk, { buffer = bufnr, desc = "Undo stage hunk" })
            map("n", "<leader>GS", gs.stage_buffer, { buffer = bufnr, desc = "Stage buffer" })
            map("n", "<leader>GR", gs.reset_buffer, { buffer = bufnr, desc = "Reset buffer" })
            map("n", "<leader>Gp", gs.preview_hunk, { buffer = bufnr, desc = "Preview hunk" })
            map("n", "<leader>Gb", function() gs.blame_line({ full = true }) end, { buffer = bufnr, desc = "Blame line" })
            map("n", "<leader>Gd", gs.diffthis, { buffer = bufnr, desc = "Diff this" })
            map("n", "<leader>GD", function() gs.diffthis("~") end, { buffer = bufnr, desc = "Diff this ~" })
            map("n", "<leader>Tb", gs.toggle_current_line_blame, { buffer = bufnr, desc = "Toggle line blame" })
            map("n", "<leader>Td", gs.toggle_deleted, { buffer = bufnr, desc = "Toggle deleted" })
        end,
    })
end

return M
