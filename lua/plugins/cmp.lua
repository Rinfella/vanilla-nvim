-- Completion plugin configuration

local cmp = require("cmp")
local luasnip = require("luasnip")

-- Load VSCode like snippets
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup()

cmp.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert {
		['C-n>'] = cmp.mapping.select_next_item(),
		['C-p>'] = cmp.mapping.select_prev_item(),
		['C-d>'] = cmp.mapping.scroll_docs(-4),
		['C-f>'] = cmp.mapping.scroll_docs(4),
		['C-Space>'] = cmp.mapping.complete(),
		['CRn>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
		['<Tab>'] = cmp.mapping(function (fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			else 
				fallback()
			end
		end, {'i', 's'}),
		['<S-Tab>'] = cmp.mapping(function (fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.expand_or_locally_jumpable() then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {'i', 's'}),
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{ name = 'buffer' },
		{ name = 'path' },
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	formatting = {
		format = function(vim_item)
			-- Set icons for completion items
			local kind_icons = {
				Text = "",
				Method = "",
				Function = "",
				Constructor = "",
				Field = "",
				Variable = "",
				Class = "ﴯ",
				Interface = "",
				Module = "",
				Property = "ﰠ",
				Unit = "",
				Value = "",
				Enum = "",
				Keyword = "",
				Snippet = "",
				Color = "",
				File = "",
				Reference = "",
				Folder = "",
				EnumMember = "",
				Constant = "",
				Struct = "",
				Event = "",
				Operator = "",
				TypeParameter = ""
			}

			vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
			return vim_item
		end
	},
}