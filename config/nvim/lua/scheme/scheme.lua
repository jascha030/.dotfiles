require('scheme.utils')

local utils = require('util')
local UserSchemeStyles = require('scheme.styles')
local UserSchemeOverRides = require('scheme.overrides')

local UserScheme = {}
UserScheme.__index = UserScheme

function UserScheme.create(scheme, styles, overrides)
    local user_scheme_loaded, _scheme = pcall(require, 'scheme.colors.' .. scheme)

    if not user_scheme_loaded then
        error('Could not find colorscheme: "' .. scheme .. '".')
    end

    styles = styles or UserSchemeStyles.create()
    overrides = overrides or UserSchemeOverRides.create()

    local default_colors = {
        magenta = '#bb9af7',
        purple = '#9d7cd8',
    }

    local default_opts = {
        italic_functions = true,
        italic_comments = true,
        transparent_sidebar = true,
        transparent = true,
    }

    local self = {
        _opts = default_opts,
        _styles = styles,
        _dark = {},
        _light = {},
    }

    for style in pairs({ dark = overrides.dark, light = overrides.light }) do
        --print(vim.inspect(style))

        self['_' .. style] = require('tokyonight.colors').setup(utils.tbl_merge(default_opts, {
            colors = default_colors,
            style = styles[style],
        }))

        for t_name, u_name in pairs(overrides[style]) do
            if not self['_' .. style][t_name] then
                error('Invalid tokyonight color: "' .. t_name .. '".')
            end

            if not _scheme[style][u_name] then
                error('Color "' .. u_name .. '" in user scheme "' .. scheme .. '".')
            end

            self['_' .. style][t_name] = _scheme[style][u_name]
        end
    end

    return setmetatable(self, UserScheme)
end

function UserScheme:update(dark)
    vim.o.background = dark and 'dark' or 'light'

    local full_opts = {
        tokyonight_style = dark and self._styles.dark or self._styles.light,
        tokyonight_colors = dark and self._dark or self._light,
    }

    for key, val in pairs(self._opts) do
        full_opts['tokyonight_' .. key] = val
    end

    vim.g = vim.tbl_deep_extend('force', vim.g, full_opts)
    vim.cmd([[colorscheme tokyonight]])
end

function UserScheme:init()
    self:update(OSDarkmodeEnabled())

    vim.api.nvim_create_autocmd('Signal', {
        pattern = 'SIGUSR1',
        callback = function()
            self:update(OSDarkmodeEnabled())
        end,
    })
end

function UserScheme:toggle()
    self:update(DarkmodeEnabled() and false or true)
end

function UserScheme.isDark()
    return DarkmodeEnabled()
end

function UserScheme:getColors()
    return DarkmodeEnabled() and self._dark or self._light
end

return UserScheme
