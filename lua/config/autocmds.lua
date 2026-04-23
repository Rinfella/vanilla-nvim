-- lua/config/autocmds.lua
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local lsp = require("config.lsp")

-- 1. Native LSP Start (Replaces lspconfig)
autocmd("FileType", {
    pattern = {
        "python", "php", "lua", "html", "css", "json", "go", "rust",
        "typescript", "javascript", "terraform", "ansible", "sql",
        "dockerfile", "yaml", "toml", "sh", "bash"
    },
    callback = function(args)
        local ft_map = {
            python = "python",
            php = "php",
            lua = "lua",
            html = "html",
            json = "json",
            go = "go",
            rust = "rust",
            typescript = "typescript",
            javascript = "javascript",
            terraform = "terraform",
            ansible = "ansible",
            sql = "sql",
            dockerfile = "dockerfile",
            yaml = "yaml",
            sh = "bash",
            bash = "bash",
        }
        local server = ft_map[args.match]
        if server then lsp.start(server) end
    end,
})

-- 2. Native Auto-Save
autocmd({ "FocusLost", "BufLeave" }, {
    group = augroup("NativeAutoSave", { clear = true }),
    callback = function()
        if vim.bo.modified and vim.bo.buftype == "" and vim.fn.expand("%") ~= "" then
            vim.cmd("silent! update")
        end
    end,
})

-- 3. Native Auto-Format
autocmd("LspAttach", {
    group = augroup("NativeLspAttach", { clear = true }),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        -- Enable Autoformat if server supports it
        if client.server_capabilities.documentFormattingProvider then
            autocmd("BufWritePre", {
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
                end,
            })
        end

        -- Keymaps specific to LSP buffers
        local opts = { buffer = args.buf, desc = "LSP" }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
    end,
})

-- 4. Yank Highlight
autocmd("TextYankPost", {
    callback = function() vim.highlight.on_yank() end,
})

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

-- 5. Plugin Update Reminder
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        vim.defer_fn(function()
            if require("lazy.status").has_updates() then
                vim.notify("🔄 Plugin updates available! Run :Lazy to update", vim.log.levels.INFO)
            end
        end, 3000)
    end,
})
