local M = {}

local config = require('jascha030.config')
local quake = require('jascha030.quake')
local utils = require('jascha030.utils')
local window = require('jascha030.window')
local counter = require('jascha030.counter')
local music = require('jascha030.music')


config:setup({})

local main_screen = config:get('builtinScreen')

local types = {
    apps = {
        name = 'Apps',
        description = 'Show, hide or open various apps.',
        mods = { 'shift', 'alt' },
        handler = function(mod, key, app)
            hs.hotkey.bind(mod, key, function()
                quake.toggle(app, main_screen)
            end)
        end,
    },
    control = {
        name = 'App controls',
        description = 'Bindings mapped to various actions related to specific apps and the window/layout system.',
        mods = { 'ctrl', 'alt' },
    },
    system = {
        name = 'System bindings',
        description = 'Uncommon key-mod bindings for system opts or actions with potentially unwanted side-effects.',
        mods = { 'ctrl', 'alt', 'cmd' },
    },
}

local function map_to_string(mod, key)
    local key_msg = nil

    for m in mod do
        key_msg = not key_msg and m or key_msg .. ', ' .. m
    end

    return '[ ' .. key_msg .. ' ] + ' .. key .. '.'
end

local function handler(mod, key, arg)
    if arg == nil then
        return
    end

    local ok, res, t = nil, nil, type(arg)

    if t ~= 'function' then
        error('Invalid argument for hotkey binding: ' .. map_to_string(mod, key))
    end

    hs.hotkey.bind(mod, key, function()
        ok, res = pcall(arg)

        if not ok then
            error('Error processing callback for hotkey binding: ' .. map_to_string(mod, key))
        else
            return res
        end
    end)
end

M.config = config
M.quake = quake
M.utils = utils
M.window = window
M.counter = counter
M.music = music

function M.setup(bindings)
    local ok, res = nil, nil

    for t, values in pairs(bindings) do
        if types[t] ~= nil then
            local type = types[t]
            local method = type.handler or handler

            for key, action in pairs(values) do
                pcall(method, type.mods, key, action)
            end
        end
    end
end

return M
