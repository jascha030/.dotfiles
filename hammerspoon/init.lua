require('hs.ipc')
hs.ipc.cliInstall()

hs.window.setShadows(false)
hs.window.animationDuration = 0

-- Spoons
hs.loadSpoon('EmmyLua')
hs.loadSpoon('SpoonInstall')

spoon.SpoonInstall:andUse('RoundedCorners', {
    start = true,
    config = { radius = 8 },
})

-- Custom modules
local js = require('jascha030')
js.config:setup({})

-- Quake terminal
js.quake.set(js.config:get('termApp'), js.config:get('builtinScreen'))

-- Hotkeys
hs.hotkey.bind({ 'ctrl', 'alt' }, 'l', function()
    js.window.manager:center()
end)

hs.hotkey.bind({ 'cmd', 'alt', 'ctrl' }, 'R', function()
    hs.reload()
end)

-- Toggle dark mode.
hs.hotkey.bind({ 'cmd', 'alt', 'ctrl' }, 'D', function()
    hs.osascript.applescript([[
      tell application "System Events"
		    tell appearance preferences
			    set dark mode to not dark mode
				end tell
			end tell
	  ]])
end)
