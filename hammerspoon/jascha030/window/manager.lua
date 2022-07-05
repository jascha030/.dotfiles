local spaces = require('hs.spaces')
local screen = require('hs.screen')

-- TODO: abstraction and extraction.

local function window_frame_eq_screen(w)
    local f = w:frame()
    local s = w:screen()
    local max = s:frame()

    return f.h == max.h and f.w == max.w and f.x == max.x and f.y == max.y
end

local WindowManager = {}
WindowManager.__index = WindowManager

-- Constructor, (tnx cpt. obvious).
function WindowManager.create(division, factor)
    local self = {
        defaultScreenWidthDivision = division or 4,
        defaultScreenWidthFactor = factor or 2,
    }

    return setmetatable(self, WindowManager)
end

-- How many times we multiply the defaultScreenWidthDivision when calculating the frame width for unsnapped windows.
-- If mainScreen is built-in, make window wider by default.
function WindowManager:getWidthFactor(selectedScreen, builtinScreen)
    local widthFactor = self.defaultScreenWidthFactor

    if builtinScreen ~= nil then
        if selectedScreen:name() == builtinScreen then
            widthFactor = 3
        end
    end

    return widthFactor
end

function WindowManager:move(application, space, builtinScreen)
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
        winFrame.w = (scrFrame.w / 4) * self:getWidthFactor(spaceScreen, builtinScreen)
        winFrame.y = scrFrame.y + ((scrFrame.h / 2) - (winFrame.h / 2))
        winFrame.x = scrFrame.x + ((scrFrame.w / 2) - (winFrame.w / 2))

        win:setFrame(winFrame, 0)
    end

    win:focus()
end

function WindowManager:center(builtinScreen)
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
    winFrame.w = (scrFrame.w / 4) * self:getWidthFactor(spaceScreen, builtinScreen)
    winFrame.y = scrFrame.y + ((scrFrame.h / 2) - (winFrame.h / 2))
    winFrame.x = scrFrame.x + ((scrFrame.w / 2) - (winFrame.w / 2))

    win:setFrame(winFrame, 0)
end

return WindowManager
