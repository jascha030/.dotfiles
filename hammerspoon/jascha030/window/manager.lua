local spaces = require('hs.spaces')
local screen = require('hs.screen')

local WindowManager = {
    defaultScreenWidthDivision = 0,
    defaultScreenWidthFactor = 0,
}

-- Constructor, (tnx cpt. obvious).
function WindowManager:new(m, division, factor)
    m = m or {}
    setmetatable(m, self)

    self.__index = self
    self.defaultScreenWidthDivision = division or 4
    self.defaultScreenWidthFactor = factor or 2

    return m
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
    while win == nil do
        win = application:mainWindow()
    end

    local spaceScreen = screen.find(spaces.spaceDisplay(space))
    local windowSpaces = spaces.windowSpaces(win)

    if windowSpaces[0] ~= space then
        win:moveToScreen(spaceScreen)
        spaces.moveWindowToSpace(win:id(), space)
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
