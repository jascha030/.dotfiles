local termUtils = require 'term'
local doubleTap = require 'doubleTap'
local settings  = require 'settings'

-- Load settings
settings:setup({})

-- Terminal Emulator App (default: 'Alacritty.app')
local termApp = settings:get('termApp')

-- Default screen
local builtinScreen = settings:get('builtInScreen')

-- DoubleTap
--    key = cmd,
--    map = term.toggle
doubleTap.action = function ()
  termUtils.toggle(termApp, builtinScreen)
end

