local M = {}

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

function M.toggle_darkmode()
    hs.osascript.applescript([[
        tell application "System Events"
            tell appearance preferences
    	        set dark mode to not dark mode
			end tell
        end tell
    ]])
end

function M.finder_cleanup_by(type)
    type = type or 'Name'

    local app = hs.application.frontmostApplication()

    if app:name() == 'Finder' then
        app:selectMenuItem({ 'View', 'Clean Up By', type })
    end
end

return M
