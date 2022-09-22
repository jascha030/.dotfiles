local JSpoon = require('jascha030')
local fn = JSpoon.fn

JSpoon.setup({
    term_app = 'WezTerm',
    spoons = {
        load = {
            -- 'EmmyLua',
            'SpoonInstall',
            'ReloadConfiguration',
        },
    },
    hotkeys = {
        system = {
            ['d'] = fn(JSpoon.toggle_darkmode),
        },
        control = {
            ['h'] = fn(hs.toggleConsole),
            ['p'] = fn(hs.itunes.playpause),
            [']'] = fn(JSpoon.music.next),
            ['['] = fn(JSpoon.music.previous),
            ['l'] = fn(JSpoon.window.center),
            ['left'] = fn(JSpoon.window.left),
            ['right'] = fn(JSpoon.window.right),
            ['return'] = fn(JSpoon.window.max),
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
    },
})
