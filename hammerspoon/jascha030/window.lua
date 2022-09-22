hs.window.animationDuration = 0

local M = {}

local BUILTIN = 'Built-in Retina Display'

local function current()
    return hs.window.focusedWindow()
end

local function scr_frame()
    return current():screen():fullFrame()
end

local function left_half(frame)
    return {
        x = frame.x,
        y = frame.y,
        w = frame.w / 2,
        h = frame.h,
    }
end

local function right_half(frame)
    return {
        x = frame.x + frame.w / 2,
        y = frame.y,
        w = frame.w / 2,
        h = frame.h,
    }
end

--@param win window
local function move_left(win)
    local frame = win:screen():fullFrame()
    local state = win:frame()

    win:setFrame(left_half(frame))
    if not win:frame():equals(state) then
        return
    end

    win:moveOneScreenWest()

    frame = win:screen():fullFrame()
    win:setFrame(right_half(frame))
end

--@param win window
local function move_right(win)
    local frame = win:screen():fullFrame()
    local state = win:frame()

    win:setFrame(right_half(frame))
    if not win:frame():equals(state) then
        return
    end

    win:moveOneScreenEast()

    frame = win:screen():fullFrame()
    win:setFrame(left_half(frame))
end

-- TODO: abstraction and extraction.
local function window_frame_eq_screen(w)
    local f = w:frame()
    local max = w:screen():frame()

    return f.h == max.h and f.w == max.w and f.x == max.x and f.y == max.y
end

-- How many times we multiply the defaultScreenWidthDivision when calculating the frame width for unsnapped windows.
-- If mainScreen is built-in, make window wider by default.
function M.getWidthFactor(selectedScreen)
    return selectedScreen:name() == BUILTIN and 3 or 2
end

function M.move(application, space)
    local win = nil
    local spaceScreen = hs.screen.find(hs.spaces.spaceDisplay(space))

    while win == nil do
        win = application:mainWindow()
    end

    local windowSpaces = hs.spaces.windowSpaces(win)
    local currentWindowSpace = windowSpaces[0]

    if currentWindowSpace ~= space then
        if true ~= window_frame_eq_screen(win) then
            win:moveToScreen(spaceScreen)
            hs.spaces.moveWindowToSpace(win:id(), space)
        end
    end

    local f = win:frame()
    local max = spaceScreen:fullFrame()

    -- Center window if not snapped left or right
    if max.x ~= f.x and max.y ~= f.y and max.x2 ~= f.x2 and max.y2 ~= f.y2 then
        f.h = (max.h / 3) * 2
        f.w = (max.w / 4) * M.getWidthFactor(spaceScreen)
        f.y = max.y + ((max.h / 2) - (f.h / 2))
        f.x = max.x + ((max.w / 2) - (f.w / 2))

        win:setFrame(f, 0)
    end

    win:focus()
end

function M.center()
    local win = hs.window.frontmostWindow()
    local space = hs.spaces.activeSpaceOnScreen(hs.screen.mainScreen())
    local spaceScreen = hs.screen.find(hs.spaces.spaceDisplay(space))
    local windowSpaces = hs.spaces.windowSpaces(win)

    if windowSpaces[0] ~= space then
        win:moveToScreen(spaceScreen)
        hs.spaces.moveWindowToSpace(win:id(), space)
    end

    local f = win:frame()
    local max = spaceScreen:fullFrame()

    f.h = (max.h / 3) * 2
    f.w = (max.w / 4) * M.getWidthFactor(spaceScreen)
    f.y = max.y + ((max.h / 2) - (f.h / 2))
    f.x = max.x + ((max.w / 2) - (f.w / 2))

    win:setFrame(f)
end

function M.max()
    current():maximize()
end

function M.left()
    move_left(current())
end

function M.right()
    move_right(current())
end

function M.min()
    current:minimize()
end

return M
