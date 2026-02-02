local M = {}

local position = require('jascha030.position')
local pos = position.new('Built-in Retina Display', 3, 2)

---@return hs.window
local function get_focused_win()
    return hs.window.focusedWindow()
end

---@param win hs.window
local function move_left(win)
    local frame = win:screen():frame()
    local state = win:frame()

    win:setFrame(pos.left_half(frame))
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
    win:setFrame(pos.right_half(frame))
end

---@param win hs.window
---@param frame hs.geometry
local function set_frame(win, frame)
    if type(win._setFrame) == 'function' then
        win:_setFrame(frame)
        return
    end

    win:setFrame(frame)
end

---@param win hs.window
local function move_right(win)
    local frame = win:screen():frame()
    local state = win:frame()

    win:setFrame(pos.right_half(frame))
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
    win:setFrame(pos.left_half(frame))
end

function M.center()
    local win = hs.window.frontmostWindow()
    local space = hs.spaces.activeSpaceOnScreen(hs.screen.mainScreen())
    local spaceScreen = hs.screen.find(hs.spaces.spaceDisplay(space))
    local windowSpaces = hs.spaces.windowSpaces(win)
    local firstSpace = windowSpaces ~= nil and windowSpaces[1] or nil

    if firstSpace ~= space then
        win:moveToScreen(spaceScreen)
        hs.spaces.moveWindowToSpace(win:id(), space)
    end

    win:setFrame(pos:centered(win, spaceScreen))
end

---@param app_or_win hs.application|hs.window
---@param space number
function M.move(app_or_win, space)
    local win = app_or_win
    local spaceScreen = hs.screen.find(hs.spaces.spaceDisplay(space))

    if type(win.mainWindow) == 'function' then
        win = win:mainWindow()
    end

    if win == nil then
        return
    end

    local windowSpaces = hs.spaces.windowSpaces(win)
    local currentWindowSpace = windowSpaces ~= nil and windowSpaces[1] or nil

    if currentWindowSpace ~= space then
        ---@diagnostic disable-next-line: param-type-mismatch
        if true ~= pos.frame_eq_screen(win) then
            win:moveToScreen(spaceScreen)
            hs.spaces.moveWindowToSpace(win:id(), space)
        end
    end

    local f = win:frame()
    local max = pos.maximized(spaceScreen:frame())

    -- Center window if not snapped left or right
    if max.x ~= f.x and max.y ~= f.y and max.x2 ~= f.x2 and max.y2 ~= f.y2 then
        ---@diagnostic disable-next-line: param-type-mismatch
        set_frame(win, pos:centered(win, spaceScreen))
    end

    win:focus()
end

---@param win hs.window
local function maximize(win)
    win:setFrame(pos.maximized(win:screen():frame()))
end

function M.max()
    maximize(get_focused_win())
end

function M.left()
    move_left(get_focused_win())
end

function M.right()
    move_right(get_focused_win())
end

function M.min()
    get_focused_win():minimize()
end

return M
