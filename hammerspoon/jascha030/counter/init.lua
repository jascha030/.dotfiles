Counter = { count = 0 }

function Counter:new(c)
    c = c or {}

    setmetatable(c, self)
    self.__index = self

    return c
end

function Counter:display()
    hs.alert.show('Count: ' .. self.count)
end

function Counter:add(display)
    display = display or true

    self.count = self.count + 1

    if display == true then
        self:display()
    end
end

function Counter:subtract(display)
    display = display or true

    self.count = self.count ~= 0 and self.count - 1 or 0

    if display == true then
        self:display()
    end
end

function Counter:reset()
    local prev = self.count
    self.count = 0

    hs.alert('Count of: ' .. prev .. ' was reset to 0', self.count)
end

--[[
hs.hotkey.bind({ 'ctrl', 'alt', 'cmd' }, '=', function()
    ActiveCounter:add(true)
end)

hs.hotkey.bind({ 'ctrl', 'alt', 'cmd' }, '-', function()
    ActiveCounter:subtract(true)
end)

hs.hotkey.bind({ 'ctrl', 'alt', 'cmd' }, 'c', function()
    ActiveCounter:display()
end)
--]]

