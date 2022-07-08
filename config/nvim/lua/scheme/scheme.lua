require('scheme.utils')

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

    local self = {
        _userscheme = _scheme,
        _styles = styles,
        _overrides = overrides,
        _dark = {},
        _light = {},
    }

    for style in pairs({ dark = overrides.dark, light = overrides.light }) do
        self['_' .. style] = require('tokyonight.colors').setup({
            colors = {
                magenta = '#bb9af7',
                purple = '#9d7cd8',
            },
            style = styles[style],
        })

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
    vim.g.tokyonight_italic_functions = true
    vim.g.tokyonight_italic_comments = true
    vim.g.tokyonight_transparent = true
    vim.g.tokyonight_transparent_sidebar = true
    vim.g.tokyonight_sidebars = { 'terminal', 'packer' }

    vim.g.tokyonight_style = dark and 'storm' or 'day'
    vim.g.tokyonight_colors = dark and self._dark or self._light

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

    vim.api.nvim_create_autocmd('Signal', { pattern = 'SIGUSR1', command = 'PackerCompile' })
end

function UserScheme:toggle()
    self:update(vim.o.background ~= 'dark')
end

function UserScheme.isDark()
    return DarkmodeEnabled()
end

function UserScheme:getColors()
    return DarkmodeEnabled() and self._dark or self._light
end

function UserScheme:getUserColors()
    return DarkmodeEnabled() and self._userscheme.dark or self._userscheme.light
end

return UserScheme
