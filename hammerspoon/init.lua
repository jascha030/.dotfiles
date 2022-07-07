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

local JSpoon = require('jascha030')

JSpoon.config:setup({})

-- Quake terminal
JSpoon.quake.set(JSpoon.config:get('termApp'), JSpoon.config:get('mainScreen'))

-- Center quake window in screen
hs.hotkey.bind({ 'ctrl', 'alt' }, 'l', function()
    JSpoon.window.manager:center()
end)

JSpoon.setup({
    system = {
        -- Reload hs config manually.
        r = hs.reload,
        -- toggle dark mode
        d = function()
            hs.osascript.applescript([[
                    tell application "System Events"
								        tell appearance preferences
									            set dark mode to not dark mode
										    end tell
								    end tell
                ]])
        end,
    },
    control = {
        -- Hammerspoon
        h = hs.toggleConsole,
        -- iTunes
        p = JSpoon.music.play,
        [']'] = JSpoon.music.next,
        ['['] = JSpoon.music.previous,
    },
    apps = {
        i = 'Music',
        s = 'Spotify',
        p = 'PhpStorm',
        l = 'Ableton Live 11 Suite',
        c = 'Chrome',
        k = 'GitKraken',
        n = 'Notes',
        w = 'Chromium',
        a = 'Safari',
    },
})
