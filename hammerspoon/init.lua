require('hs.ipc')
hs.ipc.cliInstall()

hs.window.setShadows(false)
hs.window.animationDuration = 0

-- Spoons
hs.loadSpoon('EmmyLua')
hs.loadSpoon('SpoonInstall')
hs.loadSpoon('ReloadConfiguration')

-- TODO: remove
print(hs.inspect(hs.midi.devices()))

spoon.ReloadConfiguration:start()
spoon.SpoonInstall:andUse('RoundedCorners', {
    start = true,
    config = { radius = 8 },
})

local JSpoon = require('jascha030')
local term_app, main_screen = JSpoon.getConfig('termApp'), JSpoon.getConfig('mainScreen')

-- Quake terminal
JSpoon.quake.set(term_app, main_screen)

JSpoon.hotkey.setup({
    system = {
        ['d'] = JSpoon.system.toggleDark,
    },
    control = {
        ['l'] = function()
            JSpoon.window.manager:center()
        end,
        ['h'] = hs.toggleConsole,
        ['p'] = hs.itunes.playpause,
        [']'] = JSpoon.music.next,
        ['['] = JSpoon.music.previous,
    },
    apps = {
        ['i'] = 'Music',
        ['s'] = 'Spotify',
        ['p'] = 'PhpStorm',
        ['l'] = 'Ableton Live 11 Suite',
        ['c'] = 'Chrome',
        ['k'] = 'GitKraken',
        ['n'] = 'Notes',
        ['w'] = 'Chromium',
        ['a'] = 'Safari',
    },
})

-- local timer = require('jascha030.timer')
-- local reminder = timer.create()
-- reminder:start()
