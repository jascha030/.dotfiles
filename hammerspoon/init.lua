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
            ['d'] = fn(JSpoon.system.toggle_darkmode),
            ['t'] = fn(JSpoon.toggle_term_app),
            ['a'] = fn(JSpoon.system.route_audio_to_live),
        },
        control = {
            ['a'] = function()
                if not JSpoon.audioSwitcher.isActive then
                    JSpoon.audioSwitcher:start()
                end
            end,
            ['n'] = fn(JSpoon.system.finder_cleanup_by, 'Name'),
            ['t'] = fn(JSpoon.system.finder_cleanup_by, 'Kind'),
            ['down'] = fn(JSpoon.window.min),
            ['h'] = fn(JSpoon.window.left),
            ['j'] = fn(JSpoon.window.center),
            ['k'] = fn(JSpoon.window.center),
            ['l'] = fn(JSpoon.window.right),
            ['left'] = fn(JSpoon.window.left),
            ['return'] = fn(JSpoon.window.max),
            ['right'] = fn(JSpoon.window.right),
            ['up'] = fn(JSpoon.window.center),
        },
        apps = {},
    },
})
