local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

-- Extend capabilities with nvim-cmp support
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Setup servers
local servers = {
    "lua_ls",
    "ts_ls",
    "pyright",
    "jsonls",
} -- Add your servers here
for _, server in ipairs(servers) do
    lspconfig[server].setup({
        capabilities = capabilities,
    })
end
