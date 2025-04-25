-- Autocmd for opening directoory as `nvim .` using telescope file browser
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        local arg = vim.fn.argv()[1]
        if arg and vim.fn.isdirectory(arg) == 1 then
            vim.cmd.cd(arg)
            require("telescope").extensions.file_browser.file_browser({ path = arg })
        end
    end,
})
