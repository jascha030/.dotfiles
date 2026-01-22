local JSpoon = require('jascha030')
local fn = JSpoon.fn

---@diagnostic disable-next-line: missing-fields
JSpoon.setup({
    term_app = {
        main = 'WezTerm',
        alt = 'Ghostty',
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
            ['a'] = fn(JSpoon.route_audio_to_live),
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
        },
    },
})
