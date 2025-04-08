
require("auto-format").setup({
    -- Name of the augroup
    augroup_name = "AutoFormat",

    timeout = 2000,
    -- If formatting takes longer than this amount of time, it will fail.
    
    -- These file types will not be formatted automatically
    exclude_ft = {},

    -- Prefer formatting via LSP for these file types.
    prefer_lsp = {
        "bash",
        "go",
        "html",
        "json",
        "lua",
        "php",
        "python",
        "sql",
        "yaml",
    },
})
