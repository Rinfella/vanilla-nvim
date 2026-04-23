-- lua/plugins/ui.lua

return {
    -- Icons
    {
        "echasnovski/mini.icons",
        version = false,
        config = function()
            require("mini.icons").setup()
            require("mini.icons").mock_nvim_web_devicons()
        end,
    },

    -- Theme
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function() vim.cmd.colorscheme("tokyonight-night") end,
    },

    -- Statusline
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = {
            options = { theme = "tokyonight" },
            sections = { lualine_c = { "filename" }, lualine_x = { "filetype" } },
        },
    },

    -- Noice
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
        opts = {
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                },
            },
            presets = { bottom_search = true, command_palette = true, long_message_to_split = true },
            routes = {
                -- Filter out deprecation warnings
                { filter = { event = "notify", find = "deprecat" }, opts = { skip = true } },
                { filter = { event = "msg_show", find = "deprecat" }, opts = { skip = true } },
                { filter = { event = "msg_show", find = "vim.tbl_flatten" }, opts = { skip = true } },
            },
        },
    },

    -- nvim-notify (notification customization)
    {
        "rcarriga/nvim-notify",
        event = "VeryLazy",
        opts = {
            timeout = 2000,
            stages = "static",
            max_width = 80,
        },
    },

    -- Notify Log (captures notifications to register)
    {
        "BSeblu/notify-log.nvim",
        event = "VeryLazy",
        opts = { register = "l" },
    },

    -- Dashboard
    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        config = function()
            local dashboard = require("alpha.themes.dashboard")

            -- Random Headers
            local headers = {
                {
                    "       ::::    ::: ",
                    "      :+:+:   :+:  ",
                    "     :+:+:+  +:+   ",
                    "    +#+ +:+ +#+    ",
                    "   +#+  +#+#+#     ",
                    "  #+#   #+#+#      ",
                    " ###    ####       ",
                },
                {
                    " ▙ ▌▛▀▘▞▀▖▌ ▌▜▘▙▗▌ ",
                    " ▌▌▌▙▄ ▌ ▌▚▗▘▐ ▌▘▌ ",
                    " ▌▝▌▌  ▌ ▌▝▞ ▐ ▌ ▌ ",
                    " ▘ ▘▀▀▘▝▀  ▘ ▀▘▘ ▘ ",
                },
                {
                    " ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
                    " ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
                    " ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
                    " ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
                    " ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
                    " ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
                }
            }
            -- Pick a random header
            math.randomseed(os.time())
            dashboard.section.header.val = headers[math.random(#headers)]

            -- New Buttons
            dashboard.section.buttons.val = {
                dashboard.button("f", "  Find File", ":Telescope find_files<CR>"),
                dashboard.button("e", "  New File", ":ene <BAR> startinsert <CR>"),
                dashboard.button("r", "  Recent", ":Telescope oldfiles<CR>"),
                dashboard.button("g", "  Find Text", ":Telescope live_grep<CR>"),
                dashboard.button("c", "  Config", ":e $MYVIMRC<CR>"),
                dashboard.button("l", "󰒲  Lazy", ":Lazy<CR>"),
                dashboard.button("m", "󰊠  Mason", ":Mason<CR>"),
                dashboard.button("q", "󰈆  Quit", ":qa<CR>"),
            }

            -- Footer with Plugin Count & Startup Time
            dashboard.section.footer.val = function()
                local stats = require("lazy").stats()
                local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
                return "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms"
            end

            require("alpha").setup(dashboard.config)
        end,
    },

    -- Indent Blankline
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = "BufRead",
        opts = {},
    },

    -- Colorizer
    {
        "norcalli/nvim-colorizer.lua",
        event = "BufRead",
        config = function() require("colorizer").setup() end,
    }
}
