local alert    = require("hs.alert")
local timer    = require("hs.timer")
local eventtap = require("hs.eventtap")

local events   = eventtap.event.types

local module   = {}

module.timeFrame = 1

module.action = function()
    alert("You double tapped cmd!")
end

local timeFirstControl, firstDown, secondDown = 0, false, false

-- verify that no keyboard flags are being pressed
local noFlags = function(ev)
    local result = true
    for k,v in pairs(ev:getFlags()) do
        if v then
            result = false
            break
        end
    end
    return result
end

-- verify that *only* the cmd key flag is being pressed
local onlyCtrl = function(ev)
    local result = ev:getFlags().cmd
    for k,v in pairs(ev:getFlags()) do
        if k ~= "cmd" and v then
            result = false
            break
        end
    end
    return result
end

module.eventWatcher = eventtap.new({events.flagsChanged, events.keyDown}, function(ev)
    -- if it's been too long; previous state doesn't matter
    if (timer.secondsSinceEpoch() - timeFirstControl) > module.timeFrame then
        timeFirstControl, firstDown, secondDown = 0, false, false
    end

    if ev:getType() == events.flagsChanged then
        if noFlags(ev) and firstDown and secondDown then
          if module.action then module.action() end
          timeFirstControl, firstDown, secondDown = 0, false, false
        elseif onlyCtrl(ev) and not firstDown then
          firstDown = true
          timeFirstControl = timer.secondsSinceEpoch()
        elseif onlyCtrl(ev) and firstDown then
          secondDown = true
        elseif not noFlags(ev) then
          timeFirstControl, firstDown, secondDown = 0, false, false
        end
    else
      timeFirstControl, firstDown, secondDown = 0, false, false
    end

  return false
end):start()

return module
