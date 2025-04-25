-- Dashboard configuration for alpha-nvim
local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
local wasted_hours = require("plugins.wasted-hours")

wasted_hours.setup_tracking()

-- Function to format hours nicely
local function format_hours(hours)
    -- Round off to 2 decimal places
    hours = math.floor(hours * 100) / 100
    return tostring(hours)
end

-- Custom header with ASCII art
dashboard.section.header.val = {
    "                                                     ",
    "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
    "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
    "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
    "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
    "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
    "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
    "                                                     ",
    "                        " .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch,
    "                                                     ",
    "                                                     ",
    "    Total hours wasted configuring this shit: " .. format_hours(wasted_hours.get_hours()),
    "                                                     ",
}

-- Set header color
dashboard.section.header.opts.hl = "Title"

-- Custom button content with icons and keybindings
dashboard.section.buttons.val = {
    dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
    dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
    dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
    dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
    dashboard.button("s", "  Scretch notes", ":lua require('scretch').search()<CR>"),
    dashboard.button("c", "  Configuration", ":e $MYVIMRC <CR>"),
    dashboard.button("p", "  Plugins", ":e ~/.config/nvim/lua/plugins/init.lua<CR>"),
    dashboard.button("u", "  Update plugins", ":Lazy update<CR>"),
    dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
}

-- Footer with quote
local function footer()
    local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
    local version = " " .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch

    local quote = {
        "The editor of choice for the discerning hacker.",
        "Modal editing at its finest.",
        "This is the way.",
        "Edit code at the speed of thought.",
        "Life is too short for slow text editing.",
    }

    return datetime .. "   " .. version .. "\n" .. quote[math.random(#quote)]
end

dashboard.section.footer.val = footer()
dashboard.section.footer.opts.hl = "Comment"

-- Set layout
dashboard.config.layout = {
    { type = "padding", val = 2 },
    dashboard.section.header,
    { type = "padding", val = 2 },
    dashboard.section.buttons,
    { type = "padding", val = 1 },
    dashboard.section.footer,
}

-- Set options
dashboard.config.opts.noautocmd = true

-- Setup alpha
alpha.setup(dashboard.config)

-- Auto commands for opening alpha when no arguments passed
vim.api.nvim_create_autocmd("User", {
    pattern = "LazyVimStarted",
    callback = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
        pcall(vim.cmd.AlphaRedraw)
    end,
})

-- Open alpha when closing the last buffer
vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    callback = function()
        if vim.api.nvim_buf_line_count(0) == 1 and vim.api.nvim_buf_get_lines(0, 0, -1, false)[1] == "" then
            if #vim.api.nvim_list_wins() == 1 then
                vim.cmd("Alpha")
                vim.cmd("bd #")
            end
        end
    end,
})
