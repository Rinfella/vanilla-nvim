-- LSP Configuration

-- Define on attach function with keymaps for LSP
local on_attach = function (_, bufnr)
    -- Create a convenient function for mapping
    local nmap = function (keys, func, desc)
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
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function (_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })

    -- Add diagnostic keymaps
    nmap('<leader>dl', '<cmd>Telescope diagnostics<cr>', 'List Diagnostics')
    nmap('[d', vim.diagnostic.goto_prev, 'Previous Diagnostic')
    nmap(']d', vim.diagnostic.goto_next, 'Next Diagnostic')
end

-- Setup capabilities with nvim-cpmp integration
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup Mason and LSP
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            pacakage_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

require("mason-lspconfig").setup_handlers({
    -- Default configuration for all servers
    function(server_name)
       require("lspconfig")[server_name].setup{
        on_attach = on_attach,
        capabilities = capabilities,
       }
    end,

    --Special configuration for Lua Language server
    ["lua_ls"] = function()
        require("neodev").setup()
        require("lspconfig").lua_ls.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
               Lua = {
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                    diagnostics = {
                        globals = { "vim" }
                    },
               },
            },
        }
    end,
})

-- Diagnostic configuration
vim.diagnostic.config({
    virtual_text = true,
    update_in_insert = false,
    underline = true,
    security_sort = true,
    float = {
        border = "rounded",
        source = true,
    },
})
