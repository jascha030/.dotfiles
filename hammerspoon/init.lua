require('hs.ipc')
hs.ipc.cliInstall()

hs.window.setShadows(false)
hs.window.animationDuration = 0

-- Spoons
hs.loadSpoon('EmmyLua')
hs.loadSpoon('SpoonInstall')
hs.loadSpoon('ReloadConfiguration')

spoon.ReloadConfiguration:start()

spoon.SpoonInstall:andUse('RoundedCorners', {
    start = true,
    config = { radius = 8 },
})

-- Custom modules
local js = require('jascha030')
js.config:setup({})

local mods = {
    open = { 'shift', 'alt' },
    control = { 'ctrl', 'alt' },
    system = { 'ctrl', 'alt', 'cmd' },
}

-- System Hotkeys
-- Reload hs config manually.
hs.hotkey.bind(mods.system, 'r', function()
    hs.reload()
end)

-- Toggle dark mode.
hs.hotkey.bind(mods.system, 'd', function()
    hs.osascript.applescript([[
      tell application "System Events"
		    tell appearance preferences
			    set dark mode to not dark mode
				end tell
			end tell
	  ]])
end)

-- Control Hotkeys

hs.hotkey.bind(mods.control, 'h', function()
    hs.toggleConsole()
end)

-- Quake terminal
js.quake.set(js.config:get('termApp'), js.config:get('builtinScreen'))
-- Center quake window in screen
hs.hotkey.bind(mods.control, 'l', function()
    js.window.manager:center()
end)

-- Itunes
-- Play/Pause
hs.hotkey.bind(mods.control, 'p', function()
    hs.itunes.playpause()
end)

-- Next song
hs.hotkey.bind(mods.control, ']', function()
    hs.itunes.next()

    hs.alert(hs.itunes.displayCurrentTrack)
end)

-- Previous song
hs.hotkey.bind(mods.control, '[', function()
    hs.itunes.previous()

    hs.alert(hs.itunes.displayCurrentTrack)
end)
