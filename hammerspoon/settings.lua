local M = {
    config = { iniPath = os.getenv('HOME') .. '/.hotkey.ini' },
    data = { builtinScreen = nil, termApp = 'Alacritty', tapKey = 'cmd' },
}

local utils = require('utils')

-- Validate ini.lua is installed
local status_ok, ini = pcall(require, 'lib.ini')
if not status_ok then
    error('ini.lua is required')
end

function file_exists(name)
    local f = io.open(name, 'r')
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end

function M:get(key)
    return self.data[key]
end

function M:setup(config)
    if config ~= nil then
        self.config = utils.tableMerge(self.config, config)
    end

    if self.config.iniPath ~= nil and file_exists(self.config.iniPath) then
        self.data = utils.tableMerge(self.data, ini.parse_file(self.config.iniPath))
    end
end

return M
