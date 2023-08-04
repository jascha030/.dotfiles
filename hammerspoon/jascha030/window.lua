hs.window.animationDuration = 0

local M = {}

local BUILTIN = 'Built-in Retina Display'

local function current()
    return hs.window.focusedWindow()
end

local function left_half(frame, margin)
    margin = margin or 16
    local half = margin / 2

    return {
        x = frame.x + half,
        y = frame.y + half,
        w = (frame.w / 2) - (margin - (half / 2)),
        h = frame.h - margin,
    }
end

local function right_half(frame, margin)
    margin = margin or 16
    local half = margin / 2

    return {
        x = (frame.x + frame.w / 2) + (half /2),
        y = frame.y + half,
        w = (frame.w / 2) - (margin - (half / 2)),
        h = frame.h - margin,
    }
end

local function maxed(frame, margin)
    margin = margin or 16
    local half = margin / 2

    return {
        x = frame.x + half,
        y = frame.y + half,
        w = frame.w - margin,
        h = frame.h - margin
    }
end

--@param win window
local function move_left(win)
    local frame = win:screen():frame()
    local state = win:frame()

    win:setFrame(left_half(frame))
    if not win:frame():equals(state) then
        return
    end

    state = win:frame()
    win:moveOneScreenWest()

    if win:frame():equals(state) then
        local screen = win:screen()
        win:move(win:frame():toUnitRect(screen:frame()), screen:previous(), true, 0)
    end

    frame = win:screen():frame()
    win:setFrame(right_half(frame))
end

--@param win window
local function move_right(win)
    local frame = win:screen():frame()
    local state = win:frame()

    win:setFrame(right_half(frame))
    if not win:frame():equals(state) then
        return
    end


    state = win:frame()
    win:moveOneScreenEast()

    if win:frame():equals(state) then
        local screen = win:screen()
        win:move(win:frame():toUnitRect(screen:frame()), screen:next(), true, 0)
    end

    frame = win:screen():frame()
    win:setFrame(left_half(frame))
end

local function maximize(win)
    local frame = win:screen():frame()

    frame = win:screen():frame()
    win:setFrame(maxed(frame))
end

local function window_frame_eq_screen(win)
    local f = win:frame()
    local max = win:screen():frame()

    return f.h == max.h and f.w == max.w and f.x == max.x and f.y == max.y
end

-- How many times we multiply the defaultScreenWidthDivision when calculating the frame width for unsnapped windows.
-- If mainScreen is built-in, make window wider by default.
function M.getWidthFactor(selectedScreen)
    return selectedScreen:name() == BUILTIN and 3 or 2
end

function M.center_frame(win, screen)
    local f = win:frame()
    local max = maxed(screen:fullFrame())

    f.h = (max.h / 3) * 2
    f.w = (max.w / 4) * M.getWidthFactor(screen)
    f.y = max.y + ((max.h / 2) - (f.h / 2))
    f.x = max.x + ((max.w / 2) - (f.w / 2))

    return f
end

function M.center()
    local win = hs.window.frontmostWindow()

    local space = hs.spaces.activeSpaceOnScreen(hs.screen.mainScreen())
    local spaceScreen = hs.screen.find(hs.spaces.spaceDisplay(space))
    local windowSpaces = hs.spaces.windowSpaces(win)

    local firstSpace = windowSpaces ~= nil and windowSpaces[0] or nil

    if firstSpace ~= space then
        win:moveToScreen(spaceScreen)
        hs.spaces.moveWindowToSpace(win:id(), space)
    end

    win:setFrame(M.center_frame(win, spaceScreen))
end

function M.move(application, space)
    local win = nil
    local spaceScreen = hs.screen.find(hs.spaces.spaceDisplay(space))

    while win == nil do
        win = application:mainWindow()
    end

    local windowSpaces = hs.spaces.windowSpaces(win)
    local currentWindowSpace = windowSpaces ~= nil and windowSpaces[0] or nil

    if currentWindowSpace ~= space then
        if true ~= window_frame_eq_screen(win) then
            win:moveToScreen(spaceScreen)
            hs.spaces.moveWindowToSpace(win:id(), space)
        end
    end

    local f = win:frame()
    local max = maxed(spaceScreen:frame())

    -- Center window if not snapped left or right
    if max.x ~= f.x and max.y ~= f.y and max.x2 ~= f.x2 and max.y2 ~= f.y2 then
        win:setFrame(M.center_frame(win, spaceScreen))
    end

    win:focus()
end

function M.max()
    maximize(current())
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
