require("auto-format").setup({
    -- Name of the augroup
    augroup_name = "AutoFormat",

    timeout = 2000,
    -- If formatting takes longer than this amount of time, it will fail.

    -- These file types will not be formatted automatically
    exclude_ft = {},

    -- Function to determine if LSP is available
    should_format = function(bufnr)
        local clients = vim.lsp.get_clients({ bufnr = bufnr })
        if next(clients) == nil then
            return true
        end
        return false
    end,
})
