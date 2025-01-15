---@class window.Position
---@field public screen string
---@field public width_factor table<string,number>
local M = {}

---@return window.Position
function M.new(builtin_screen, builtin_w_factor, default_w_factor)
    return setmetatable({
        screen = builtin_screen,
        width_factor = {
            builtin = builtin_w_factor,
            default = default_w_factor,
        },
    }, { __index = M })
end

---@return string
function M:get_builtin()
    return self.screen
end

---@return boolean
function M:is_builtin(screen)
    return screen:name() == self:get_builtin()
end

-- How many times we multiply the defaultScreenWidthDivision when calculating the frame width for unsnapped windows.
-- If mainScreen is built-in, make window wider by default.
--
---@return number
function M:get_width_factor(screen)
    local k = self:is_builtin(screen) and 'builtin' or 'default'

    return self.width_factor[k]
end

---@return boolean
function M.frame_eq_screen(win)
    local f = win:frame()
    local max = win:screen():frame()

    return f.h == max.h and f.w == max.w and f.x == max.x and f.y == max.y
end

function M.left_half(frame, margin)
    margin = margin or 16
    local half = margin / 2

    return {
        x = frame.x + half,
        y = frame.y + half,
        w = (frame.w / 2) - (margin - (half / 2)),
        h = frame.h - margin,
    }
end

function M.right_half(frame, margin)
    margin = margin or 16
    local half = margin / 2

    return {
        x = (frame.x + frame.w / 2) + (half / 2),
        y = frame.y + half,
        w = (frame.w / 2) - (margin - (half / 2)),
        h = frame.h - margin,
    }
end

function M.maximized(frame, margin)
    margin = margin or 16
    local half = margin / 2

    return {
        x = frame.x + half,
        y = frame.y + half,
        w = frame.w - margin,
        h = frame.h - margin,
    }
end

function M:centered(win, screen)
    local f = win:frame()
    local max = M.maximized(screen:fullFrame())

    f.h = (max.h / 3) * 2
    f.w = (max.w / 4) * self:get_width_factor(screen)
    f.y = max.y + ((max.h / 2) - (f.h / 2))
    f.x = max.x + ((max.w / 2) - (f.w / 2))

    return f
end

return M
