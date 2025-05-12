local M = {}

function M.setup()
    local loaded = false
    local timer = vim.loop.new_timer()
    local retry_interval = 60 * 1000 -- 60s
    local timeout = 20             -- seconds

    local function load_copilot()
        if loaded then return end
        loaded = true

        local opts = {
            panel = { enabled = false },
            suggestion = {
                auto_trigger = true,
                debounce = 75,
                keymap = {
                    accept = "<M-a>",
                    accept_word = "<M-w>",
                    accept_line = "<M-l>",
                    next = "<M-]>",
                    prev = "<M-[>",
                    dismiss = "<M-/>",
                },
            },
            filetypes = {
                ["*"] = true,
            },
        }

        require("copilot").setup(opts)

        -- nvim-cmp and luasnip integration
        local cmp = require("cmp")
        local copilot = require("copilot.suggestion")
        local luasnip = require("luasnip")

        local function set_trigger(trigger)
            vim.b.copilot_suggestion_auto_trigger = trigger
            vim.b.copilot_suggestion_hidden = not trigger
        end

        -- Disable Copilot when cmp menu is open
        cmp.event:on("menu_opened", function()
            if copilot.is_visible() then
                copilot.dismiss()
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
                "--max-time", tostring(timeout),
                "--silent",
                "--fail",
                "https://copilot-proxy.githubusercontent.com/_ping"
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
