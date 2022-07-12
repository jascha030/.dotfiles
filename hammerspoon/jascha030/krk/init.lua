local M = {}

-- This is because KRK Rokit Studio Monitors have a pesky 20 min standby timer, when they are on low volume.
-- My solution so far has been to open Ableton Live and play a loop, which begins with a short note of 10Hz.
-- Which is too low for human ears to pick up, and too low for my subwoofer to really produce anything.
-- But I can play it nice and load so my speakers wake up, and then lower the volume of what ever I am listening to (probably falling asleep to a podcast).

local source = hs.fs.currentDir() .. 'krk_10hz.wav'
local wakeup_sound = hs.sound.getByFile(source)

local time = 20 * 60
local timer = nil
local playing = false

local function wakeup()
    wakeup_sound:play()
end

local function init_timer()
    if timer == nil then
        timer = hs.timer.doEvery(time, function()
            wakeup()
        end)
    end
end

function M.toggle_active()
    playing = not playing

    if playing == true and timer == nil then
        init_timer()
    end

    local p = playing and 'on' or 'off'

    hs.alert('krk wakeup:' .. p)
end

M.wakeup = wakeup

return M
