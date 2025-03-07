local JSpoon = require('jascha030')
local fn = JSpoon.fn

JSpoon.setup({
    term_app = {
        main = 'Ghostty',
        alt = 'WezTerm',
    },
    spoons = {
        load = {
            'EmmyLua',
            'SpoonInstall',
            'ReloadConfiguration',
        },
    },
    hotkeys = {
        system = {
            ['d'] = fn(JSpoon.toggle_darkmode),
            ['t'] = fn(JSpoon.toggle_term_app),
        },
        control = {
            ['h'] = fn(JSpoon.window.left),
            ['left'] = fn(JSpoon.window.left),
            ['l'] = fn(JSpoon.window.right),
            ['right'] = fn(JSpoon.window.right),
            ['j'] = fn(JSpoon.window.center),
            ['k'] = fn(JSpoon.window.center),
            ['up'] = fn(JSpoon.window.center),
            ['down'] = fn(JSpoon.window.min),
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
