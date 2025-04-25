local M = {}

-- Path to the file storing wasted hours
local hours_file = vim.fn.stdpath("data") .. "/wasted_hours.txt"
-- Track session start time
local session_start_time = os.time()
-- Track if we've already set up the timers
local setup_done = false

-- Function to read current wasted hours
function M.get_hours()
    if vim.fn.filereadable(hours_file) == 0 then
        local file = io.open(hours_file, "w")
        if file then
            file:write("50") -- Initial value of 50 hours
            file:close()
        end
        return 50
    end

    local file = io.open(hours_file, "r")
    if not file then return 50 end
    local hours = tonumber(file:read("*all")) or 50
    file:close()
    return hours
end

-- Function to update the wasted hours with the current session time
function M.update_session_time()
    local current_time = os.time()
    local session_duration_hours = (current_time - session_start_time) / 3600

    -- Read current value
    local current_hours = M.get_hours()

    -- Update with session time
    local new_hours = current_hours + session_duration_hours

    -- Write back to file
    local file = io.open(hours_file, "w")
    if file then
        file:write(tostring(new_hours))
        file:close()
    end

    -- Reset session start time for next update
    session_start_time = current_time

    return new_hours
end

-- Setup automatic tracking
function M.setup_tracking()
    if setup_done then return end

    -- Update session time every minute
    local timer = vim.loop.new_timer()
    timer:start(60000, 60000, vim.schedule_wrap(function()
        M.update_session_time()

        -- Redraw alpha dashboard if it's open
        if package.loaded["alpha"] and package.loaded["alpha"].redraw then
            require("alpha").redraw()
        end
    end))

    -- Save session time when exiting Neovim
    vim.api.nvim_create_autocmd("VimLeavePre", {
        callback = function()
            M.update_session_time()
        end,
    })

    setup_done = true
end

return M
