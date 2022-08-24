local spaces = require('hs.spaces')
local screen = require('hs.screen')

local BUILTIN = 'Built-in Retina Display'

-- TODO: abstraction and extraction.

local function window_frame_eq_screen(w)
    local f = w:frame()
    local max = w:screen():frame()

    return f.h == max.h and f.w == max.w and f.x == max.x and f.y == max.y
end

local function winframe_eq_borders(w)
    local f, sf = w:frame(), w:screen():frame()
    local eq, c = { h = false, w = false }, 0

    for k in 'h', 'w' do
        if f[k] == sf[k] then
            c = c + 1
            eq[k] = true
        end
    end

    return eq, c
end

local function winframe_touching(w)
    local f, sf = w:frame(), w:screen():frame()
    local eq, c = { x = false, y = false, x2 = false, y2 = false }, 0

    for k in 'x', 'y', 'x2', 'y2' do
        if f[k] == sf[k] then
            c = c + 1
            eq[k] = true
        end
    end

    return eq, c
end

local M = {}

-- How many times we multiply the defaultScreenWidthDivision when calculating the frame width for unsnapped windows.
-- If mainScreen is built-in, make window wider by default.
function M.getWidthFactor(selectedScreen)
    return selectedScreen:name() == BUILTIN and 3 or 2
end

function M.move(application, space)
    local win = nil
    local spaceScreen = screen.find(spaces.spaceDisplay(space))

    while win == nil do
        win = application:mainWindow()
    end

    local windowSpaces = spaces.windowSpaces(win)
    local currentWindowSpace = windowSpaces[0]

    if currentWindowSpace ~= space then
        if true ~= window_frame_eq_screen(win) then
            win:moveToScreen(spaceScreen)
            spaces.moveWindowToSpace(win:id(), space)
        end
    end

    local winFrame = win:frame()
    local scrFrame = spaceScreen:fullFrame()

    -- Center window if not snapped left or right
    if
        scrFrame.x ~= winFrame.x
        and scrFrame.y ~= winFrame.y
        and scrFrame.x2 ~= winFrame.x2
        and scrFrame.y2 ~= winFrame.y2
    then
        winFrame.h = (scrFrame.h / 3) * 2
        winFrame.w = (scrFrame.w / 4) * M.getWidthFactor(spaceScreen)
        winFrame.y = scrFrame.y + ((scrFrame.h / 2) - (winFrame.h / 2))
        winFrame.x = scrFrame.x + ((scrFrame.w / 2) - (winFrame.w / 2))

        win:setFrame(winFrame, 0)
    end

    win:focus()
end

function M.center()
    local win = hs.window.frontmostWindow()
    local space = hs.spaces.activeSpaceOnScreen(hs.screen.mainScreen())
    local spaceScreen = screen.find(spaces.spaceDisplay(space))
    local windowSpaces = spaces.windowSpaces(win)

    if windowSpaces[0] ~= space then
        win:moveToScreen(spaceScreen)
        spaces.moveWindowToSpace(win:id(), space)
    end

    local winFrame = win:frame()
    local scrFrame = spaceScreen:fullFrame()

    winFrame.h = (scrFrame.h / 3) * 2
    winFrame.w = (scrFrame.w / 4) * M.getWidthFactor(spaceScreen)
    winFrame.y = scrFrame.y + ((scrFrame.h / 2) - (winFrame.h / 2))
    winFrame.x = scrFrame.x + ((scrFrame.w / 2) - (winFrame.w / 2))

    win:setFrame(winFrame, 0)
end

return M
