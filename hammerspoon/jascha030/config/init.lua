local ini = require('jascha030.config.ini')
local utils = require('jascha030.utils')
local iniPath = os.getenv('HOME') .. '/.hotkey.ini'

local UserConfig = {
    _data = {
        builtinScreen = nil,
        termApp = 'Alacritty',
        tapKey = 'cmd',
    },
}

UserConfig.__index = UserConfig

function UserConfig.create(path)
    local o = setmetatable({}, UserConfig)

    path = path or iniPath

    if utils.file_exists(path) then
        o._data = utils.table_merge(o._data, ini.parse_file(path))
    end

    return o
end

function UserConfig:get(key)
    return self._data[key]
end

return UserConfig
