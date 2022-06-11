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
