local termUtils = require('term')
local doubleTap = require('doubleTap')
local settings = require('settings')

-- Globals and init.
hs.spoons.use('EmmyLua')

hs.window.animationDuration = 0
hs.window.setShadows(false)

-- Load settings
settings:setup({})

-- Terminal Emulator App (default: 'Alacritty.app')
local termApp = settings:get('termApp')

-- Default screen
local builtinScreen = settings:get('builtinScreen')

-- Global values
hs.window.setShadows(false)
hs.window.animationDuration = 0

-- DoubleTap
--    key = cmd,
--    map = term.toggle
doubleTap.action = function()
    termUtils.toggle(termApp, builtinScreen)
end
