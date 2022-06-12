local status_ok, ini = pcall(require, 'jascha030.config.ini')
if not status_ok then
    error('ini.lua is required')
end
local utils = require('jascha030.utils')

local function file_exists(name)
    local f = io.open(name, 'r')
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end

local M = {
    config = {
        iniPath = os.getenv('HOME') .. '/.hotkey.ini',
    },
    data = {
        builtinScreen = nil,
        termApp = 'Alacritty',
        tapKey = 'cmd',
    },
}

function M:get(key)
    return self.data[key]
end

function M:setup(config)
    if config ~= nil then
        self.config = utils.table_merge(self.config, config)
    end

    if self.config.iniPath ~= nil and file_exists(self.config.iniPath) then
        self.data = utils.table_merge(self.data, ini.parse_file(self.config.iniPath))
    end
end

return M
