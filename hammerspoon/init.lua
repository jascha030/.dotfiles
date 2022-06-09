require('hs.ipc')

hs.ipc.cliInstall()
hs.spoons.use('EmmyLua')

hs.window.setShadows(false)
hs.window.animationDuration = 0

hs.loadSpoon('SpoonInstall')
spoon.SpoonInstall:andUse('RoundedCorners', { start = true, config = { radius = 8 } })

local utils = require('utils')
local settings = require('settings')
local quake = require('quake')

-- Load settings
settings:setup({})

-- Terminal Emulator App (default: 'Alacritty.app')
-- Default screen
local app = settings:get('termApp')
local screen = settings:get('builtinScreen')
local windowManager = utils.window.manager(4, 2)

-- Enables quake terminal.
--
-- Term app: Wezterm
-- Trigger: Double tap cmd
quake.set(app, screen)

-- Hotkeys
hs.hotkey.bind({ 'ctrl', 'alt' }, 'l', function()
    windowManager:center()
end)
