require('hs.ipc')
hs.ipc.cliInstall()

hs.window.setShadows(false)
hs.window.animationDuration = 0

-- Spoons
hs.loadSpoon('EmmyLua')
hs.loadSpoon('SpoonInstall')
hs.loadSpoon('ReloadConfiguration')

local TERM_APP = 'WezTerm'

spoon.ReloadConfiguration:start()
spoon.SpoonInstall:andUse('RoundedCorners', {
    start = true,
    config = { radius = 8 },
})

local JSpoon = require('jascha030')
local music = require('jascha030.music')

-- Quake terminal
require('jascha030.quake').set(TERM_APP)

JSpoon.hotkey.setup({
    system = {
        ['d'] = JSpoon.system.toggleDark,
    },
    control = {
        ['h'] = hs.toggleConsole,
        ['l'] = function()
            require('jascha030.window').center()
        end,
        ['p'] = function()
            hs.itunes.playpause()
        end,
        [']'] = function()
            music.next()
        end,
        ['['] = function()
            music.previous()
        end,
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
