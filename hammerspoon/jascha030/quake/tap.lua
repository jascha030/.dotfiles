local alert = require('hs.alert')
local timer = require('hs.timer')
local eventtap = require('hs.eventtap')

local events = eventtap.event.types
local timeFirstControl, firstDown, secondDown = 0, false, false

local function no_flags(ev)
    local result = true

    for k, v in pairs(ev:getFlags()) do
        if v then
            result = false
            break
        end
    end

    return result
end

local function only_cmd(ev)
    local result = ev:getFlags().cmd

    for k, v in pairs(ev:getFlags()) do
        if k ~= 'cmd' and v then
            result = false
            break
        end
    end

    return result
end

local function default_callback()
    alert('You double tapped cmd!')
end

local M = {
    timeFrame = 1,
    action = default_callback
}

M.eventWatcher = eventtap.new({ events.flagsChanged, events.keyDown }, function(ev)
    -- if it's been too long; previous state doesn't matter
    if (timer.secondsSinceEpoch() - timeFirstControl) > M.timeFrame then
        timeFirstControl, firstDown, secondDown = 0, false, false
    end

    if ev:getType() == events.flagsChanged then
        if no_flags(ev) and firstDown and secondDown then
            if M.action then
                M.action()
            end
            timeFirstControl, firstDown, secondDown = 0, false, false
        elseif only_cmd(ev) and not firstDown then
            firstDown = true
            timeFirstControl = timer.secondsSinceEpoch()
        elseif only_cmd(ev) and firstDown then
            secondDown = true
        elseif not no_flags(ev) then
            timeFirstControl, firstDown, secondDown = 0, false, false
        end
    else
        timeFirstControl, firstDown, secondDown = 0, false, false
    end

    return false
end):start()

return M
