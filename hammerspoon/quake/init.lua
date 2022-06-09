local term = require('quake.term')
local tap = require('quake.tap')
local settings = require('settings')

-- Load settings
settings:setup({})

-- Terminal Emulator App (default: 'Alacritty.app')
-- Default screen
local app = settings:get('termApp')
local screen = settings:get('builtinScreen')

-- DoubleTap
--    key = cmd,
--    map = term.toggle
tap.action = function()
    term.toggle(app, screen)
end
