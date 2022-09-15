local BUILTIN = 'Built-in Retina Display'

local M = {}

function M.get()
    return hs.window.focusedWindow()
end

local function get_frames()
    local w = M.get()

    return w, w:frame(), w:screen():frame()
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

function M.maximize()
    local win, f, max = get_frames()

    f.x = max.x
    f.y = max.y
    f.w = max.w
    f.h = max.h

    win:setFrame(f)
end

function M.left()
    local win, f, max = get_frames()

    f.x = max.x
    f.y = max.y
    f.w = max.w / 2
    f.h = max.h

    win:setFrame(f)
end

function M.right()
    local win, f, max = get_frames()

    f.w = max.w / 2
    f.h = max.h
    f.x = max.x + (max.w / 2)
    f.y = max.y

    win:setFrame(f)
end

function M.setup()
    hs.window.animationDuration = 0
end

-- function M.setup(config)
--     config = config or {
--         enablegrid = false,
--         grid = '2x2',
--         margins = '0,0',
--     }
--
--     hs.window.animationDuration = 0
--
--     hs.grid.setGrid(config.grid)
--     hs.grid.setMargins(config.margins)
-- end

return M
