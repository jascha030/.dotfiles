local M = {}

local UserSchemeStyles = require('scheme.styles')
local UserSchemeOverRides = require('scheme.overrides')
local UserScheme = require('scheme.scheme')

local function default_overrides()
    return {
        yellow = 'yellow',
        red = 'red',
        cyan = 'cyan',
        orange = 'red',
        green = 'green',
        green1 = 'cyan',
    }
end

local function default_config()
    local config = require('scheme.config')

    config.overrides.dark = default_overrides()
    config.overrides.light = default_overrides()

    return config
end

M.utils = require('util')

M.config = default_config()

M.styles = UserSchemeStyles

M.overrides = UserSchemeOverRides

M.setup = function(config)
    local defaults = default_config()

    config = vim.tbl_deep_extend('force', defaults, config)

    local scheme = UserScheme.create(
        config.scheme,
        UserSchemeStyles.create(config.styles.dark, config.styles.light),
        UserSchemeOverRides.create(config.overrides.dark, config.overrides.light)
    )

    scheme:init()

    return scheme
end

return M
