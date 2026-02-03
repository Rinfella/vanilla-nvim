-- Copilot.lua

local M = {}

function M.setup()
	local loaded = false
	local timer = vim.loop.new_timer()
	local retry_interval = 60 * 1000 -- 60s
	local timeout = 20 -- seconds

	local function load_copilot()
		if loaded then
			return
		end
		loaded = true

		local opts = {
			panel = { enabled = false },
			suggestion = {
				auto_trigger = true,
				debounce = 75,
				keymap = {
					-- Disable built-in keymapping to prevent E31 errors
					-- We will map these manually below
					accept = false,
					accept_word = false,
					accept_line = false,
					next = false,
					prev = false,
					dismiss = false,
				},
			},
			filetypes = {
				["*"] = true,
			},
		}

		require("copilot").setup(opts)

		-- Manually set keymaps to avoid the "Could not unset keymap" bug
		local suggestion = require("copilot.suggestion")
		local map = vim.keymap.set

		-- Only run the command if the suggestion is visible
		local function suggestion_action(fn)
			return function()
				if suggestion.is_visible() then
					fn()
				end
			end
		end

		map("i", "<M-a>", suggestion_action(suggestion.accept), { desc = "[Copilot] Accept" })
		map("i", "<M-w>", suggestion_action(suggestion.accept_word), { desc = "[Copilot] Accept Word" })
		map("i", "<M-l>", suggestion_action(suggestion.accept_line), { desc = "[Copilot] Accept Line" })
		map("i", "<M-]>", suggestion_action(suggestion.next), { desc = "[Copilot] Next Suggestion" })
		map("i", "<M-[>", suggestion_action(suggestion.prev), { desc = "[Copilot] Prev Suggestion" })
		map("i", "<M-/>", suggestion_action(suggestion.dismiss), { desc = "[Copilot] Dismiss" })

		-- nvim-cmp and luasnip integration
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		local function set_trigger(trigger)
			vim.b.copilot_suggestion_auto_trigger = trigger
			vim.b.copilot_suggestion_hidden = not trigger
		end

		-- Disable Copilot when cmp menu is open
		cmp.event:on("menu_opened", function()
			if suggestion.is_visible() then
				suggestion.dismiss()
			end
			set_trigger(false)
		end)

		-- Re-enable Copilot when cmp closes, if not in a snippet
		cmp.event:on("menu_closed", function()
			set_trigger(not luasnip.expand_or_locally_jumpable())
		end)

		-- Also disable when inside snippet nodes
		vim.api.nvim_create_autocmd("User", {
			pattern = { "LuasnipInsertNodeEnter", "LuasnipInsertNodeLeave" },
			callback = function()
				set_trigger(not luasnip.expand_or_locally_jumpable())
			end,
		})

		vim.notify("[copilot] Connected and loaded ✅", vim.log.levels.INFO)
	end

	local function check_api()
		local stdout = vim.loop.new_pipe(false)
		local stderr = vim.loop.new_pipe(false)

		local handle
		handle = vim.loop.spawn("curl", {
			args = {
				"--max-time",
				tostring(timeout),
				"--silent",
				"--fail",
				"https://copilot-proxy.githubusercontent.com/_ping",
			},
			stdio = { nil, stdout, stderr },
		}, function(code)
			stdout:close()
			stderr:close()
			handle:close()

			if code == 0 then
				vim.schedule(load_copilot)
				timer:stop()
			else
				vim.schedule(function()
					vim.notify("[copilot] API unreachable. Retrying in 60s…", vim.log.levels.WARN)
				end)
			end
		end)
	end

	vim.defer_fn(check_api, 1000)

	timer:start(retry_interval, retry_interval, function()
		if not loaded then
			check_api()
		else
			timer:stop()
		end
	end)
end

return M
