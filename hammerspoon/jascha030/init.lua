local M = {}

local config = require('jascha030.config')

M.hotkey = require('jascha030.hotkey')
M.quake = require('jascha030.quake')
M.utils = require('jascha030.utils')
M.window = require('jascha030.window')
M.music = require('jascha030.music')
M.utils = require('jascha030.utils')
M.system = require('jascha030.system')

-- Default config
local conf = nil

function M.setConfigFile(path)
    if not M.utils.file_exists(path) then
        error('Could not find config file: "' .. path .. '".')
    end

    conf = config.create(path)
end

function M.getConfig(name)
    if not conf then
        conf = config.create()
    end

    return conf:get(name)
end

return M
