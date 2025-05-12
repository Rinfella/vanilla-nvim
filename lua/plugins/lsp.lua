-- LSP Configuration

-- Define on_attach function with keymaps for LSP
local on_attach = function(_, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    -- LSP Keymaps
    nmap('<leader>rn', vim.lsp.buf.rename, 'Rename')
    nmap('<leader>ca', vim.lsp.buf.code_action, 'Code Action')
    nmap('gd', vim.lsp.buf.definition, 'Go to Definition')
    nmap('gD', vim.lsp.buf.declaration, 'Go to Declaration')
    nmap('gi', vim.lsp.buf.implementation, 'Go to Implementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type Definition')
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')

    -- Telescope integration for some LSP features
    nmap('gr', require('telescope.builtin').lsp_references, 'Go to References')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols')

    -- Create additional commands
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })

    -- Add diagnostic keymaps
    nmap('<leader>dl', '<cmd>Telescope diagnostics<cr>', 'List Diagnostics')
    nmap('[d', vim.diagnostic.goto_prev, 'Previous Diagnostic')
    nmap(']d', vim.diagnostic.goto_next, 'Next Diagnostic')
end

-- Setup capabilities with nvim-cmp integration
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Configure Lua language server
vim.lsp.config('lua_ls', {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = {
                globals = { 'vim', 'require' },
            },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
})

-- Initialize mason
require("mason").setup()

-- Setup mason-lspconfig
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls" },
    -- automatic_enable is true by default; explicitly setting it for clarity
    automatic_enable = true,
})

-- Diagnostic configuration
vim.diagnostic.config({
    virtual_text = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
        border = "rounded",
        source = true,
    },
})
