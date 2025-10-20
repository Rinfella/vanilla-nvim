-- Setup Mason
require("mason").setup()

-- Configure filetype detection for .env files
vim.filetype.add({
	pattern = {
		["%.env"] = "dotenv",
		["%.env%..*"] = "dotenv",
	},
	filename = {
		[".env"] = "dotenv",
		[".env.local"] = "dotenv",
		[".env.example"] = "dotenv",
		[".env.production"] = "dotenv",
		[".env.development"] = "dotenv",
		[".env.test"] = "dotenv",
	},
})

-- Configure global capabilities for new 0.11+ API
vim.lsp.config("*", {
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	-- Global on_attach function call for all LSP servers
	on_attach = function(client, bufnr)
		-- Enable completion if the client supports it
		-- if client.supports_method("textDocument/completion") then
		-- 	vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
		-- end

		-- Enable completion triggered by <C-x><C-o>
		vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
		-- Buffer local mappings
		local opts = { buffer = bufnr }
		local map = vim.keymap.set
		map("n", "gD", vim.lsp.buf.declaration, opts)
		map("n", "gd", vim.lsp.buf.definition, opts)
		map("n", "K", vim.lsp.buf.hover, opts)
		map("n", "gi", vim.lsp.buf.implementation, opts)
		map("n", "<C-s><C-h>", vim.lsp.buf.signature_help, opts)
		map("n", "<Space>wa", vim.lsp.buf.add_workspace_folder, opts)
		map("n", "<Space>wr", vim.lsp.buf.remove_workspace_folder, opts)
		map("n", "<Space>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspacefolders()))
		end, opts)
		map("n", "<Space>D", vim.lsp.buf.type_definition, opts)
		map("n", "<Space>rn", vim.lsp.buf.rename, opts)
		map({ "n", "v" }, "<Space>ca", vim.lsp.buf.code_action, opts)
		map("n", "gr", vim.lsp.buf.references, opts)
		map("n", "<Space>f", function()
			vim.lsp.buf.format()({ async = true })
		end, opts)
	end,
})

-- Setup Mason-lspconfig
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"pyright",
		"jsonls",
		"intelephense",
		"html",
	},

	handlers = {
		-- Default handler for all servers
		function(server_name)
			vim.lsp.enable(server_name)
		end,

		-- Server-specific configurations
		["intelephense"] = function()
			vim.lsp.config.intelephense = {
				settings = {
					intelephense = {
						files = {
							maxSize = 1000000,
						},
					},
				},
			}
			vim.lsp.enable("intelephense")
		end,
	},
})
