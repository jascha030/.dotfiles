local alert = hs.alert
local timer = hs.timer
local eventtap = hs.eventtap

local events = eventtap.event.types
local timeFirstControl, firstDown, secondDown = 0, false, false

local function no_flags(event)
    local result = true

    for _, v in pairs(event:getFlags()) do
        if v then
            result = false
            break
        end
    end

    return result
end

local function only_cmd(event)
    local result = event:getFlags().cmd

    for k, v in pairs(event:getFlags()) do
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
    action = default_callback,
}

M.eventWatcher = eventtap
    .new({ events.flagsChanged, events.keyDown }, function(event)
        -- if it's been too long; previous state doesn't matter
        if (timer.secondsSinceEpoch() - timeFirstControl) > M.timeFrame then
            timeFirstControl, firstDown, secondDown = 0, false, false
        end

        if event:getType() == events.flagsChanged then
            if no_flags(event) and firstDown and secondDown then
                if M.action then
                    M.action()
                end
                timeFirstControl, firstDown, secondDown = 0, false, false
            elseif only_cmd(event) and not firstDown then
                firstDown = true

                ---@diagnostic disable-next-line: cast-local-type
                timeFirstControl = timer.secondsSinceEpoch()
            elseif only_cmd(event) and firstDown then
                secondDown = true
            elseif not no_flags(event) then
                timeFirstControl, firstDown, secondDown = 0, false, false
            end
        else
            timeFirstControl, firstDown, secondDown = 0, false, false
        end

        return false
    end)
    :start()

return M
