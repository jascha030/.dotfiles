local M = {}
local quake = require('jascha030.quake')

---@class JSpoon.Config
---@field term_app table{main: string, alt: string}
---@field spoons table{load: string[]}
---@field hotkeys table{system: table<string, function>, control: table<string, function>, apps: table<string, string>}

---@type boolean
local loaded = false

---@param f function|any
---@param ... any
---@return function
function M.fn(f, ...)
    local v = { ... }

    if type(f) ~= 'function' then
        local prev = f
        -- stylua: ignore
        f = function(...) return prev(...) end
    end

    return function()
        local ok, res = pcall(f, v)
        return ok and res
    end
end

function M.toggle_darkmode()
    hs.osascript.applescript([[
        tell application "System Events"
            tell appearance preferences
    	        set dark mode to not dark mode
			end tell
        end tell
    ]])
end

function M.toggle_term_app()
    if not quake then
        error('Dafuq did you do?')
    end

    quake.toggle_alt()
end

--- I often use a composite interface to toggle to my default Scarlett 18i20 w/ alternative routing which I use with a ABL Live project so I can pass all my Mac audio through a MIDI-controllable FX chain before it goes to the default output channels. ¯\_(ツ)_/¯
function M.route_audio_to_live()
    local target_device_name = 'Ewaja' -- Composite Device name
    local live_project = os.getenv('HOME') .. '/Documents/route_audio.als'

    if not hs.fs.attributes(live_project) then
        hs.alert.show('Missing Live project: ' .. live_project)
        return
    end

    local target_device = nil

    ---@diagnostic disable-next-line: undefined-field
    if hs.audiodevice.current().name ~= target_device_name then
        local devices = hs.audiodevice.allOutputDevices()

        ---@diagnostic disable-next-line: param-type-mismatch
        for _, device in pairs(devices) do
            if device:name() == target_device_name then
                target_device = device
                break
            end
        end

        if not target_device then
            hs.alert.show('Audio Interface "' .. target_device_name .. '" not found!')
            return
        end
    end

    local live = hs.application.find('Ableton Live 12 Suite')

    if live and live:isRunning() and target_device then
        target_device:setDefaultOutputDevice()
        return
    end

    local _, status, _, rc = hs.execute('open "' .. live_project .. '"')

    if not status then
        hs.alert.show('Failed to open project (exit code: ' .. tostring(rc) .. ')')
        return
    end

    if target_device then
        target_device:setDefaultOutputDevice()
    end
end

---@param config JSpoon.Config
function M.setup(config)
    if loaded == true then
        return
    end

    loaded = true

    require('hs.ipc')

    hs.ipc.cliInstall()
    hs.window.setShadows(false)
    hs.window.animationDuration = 0

    for _, sp in pairs(config.spoons.load) do
        hs.loadSpoon(sp)
    end

    spoon.SpoonInstall:andUse('RoundedCorners', { start = true, config = { radius = 8 } })
    spoon.ReloadConfiguration:start()

    quake.set(config.term_app)
    require('jascha030.hotkey').setup(config.hotkeys)

    hs.alert.show('🔨🥄 load done.')
end

return setmetatable(M, {
    __index = function(_, key)
        local ok, submodule = pcall(require, 'jascha030.' .. key)

        if not ok then
            error('Unknown module "' .. key .. '"')
        end

        return submodule
    end,
})
