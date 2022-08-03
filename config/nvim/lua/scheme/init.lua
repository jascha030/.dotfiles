require('scheme.utils')
local config = require('scheme.config')
local util = require('utils')

local loaded, loaded_scheme, user_config = false, nil, nil

local M = {}

local _default_overrides = {
    yellow = 'yellow',
    red = 'red',
    cyan = 'cyan',
    orange = 'red',
    green = 'green',
    green1 = 'cyan',
}

local default_tokyopts = {
    tokyonight_italic_functions = true,
    tokyonight_italic_comments = true,
    tokyonight_transparent = true,
    tokyonight_transparent_sidebar = true,
    tokyonight_sidebars = { 'terminal', 'packer', 'nvim-tree' },
}

local UserSchemeStyles, UserSchemeOverRides, UserScheme = {}, {}, {}
UserSchemeStyles.__index = UserSchemeStyles
UserSchemeOverRides.__index = UserSchemeOverRides
UserScheme.__index = UserScheme

function UserSchemeStyles.create(dark, light)
    return setmetatable({
        dark = dark or 'storm',
        light = light or 'day',
    }, UserSchemeStyles)
end

function UserSchemeOverRides.create(dark, light)
    return setmetatable({
        dark = dark or {},
        light = light or {},
    }, UserSchemeOverRides)
end

function UserScheme.create(c)
    local user_scheme_loaded, _scheme = pcall(require, 'scheme.colors.' .. c.scheme)
    if not user_scheme_loaded then
        error('Could not find colorscheme: "' .. c.scheme .. '".')
    end

    local self = {
        _config = c,
        _userscheme = _scheme,
        _overrides = c.overrides,
        _styles = c.styles,
        _dark = {},
        _light = {},
    }

    for style in pairs({ dark = c.overrides.dark, light = c.overrides.light }) do
        self['_' .. style] = require('tokyonight.colors').setup({
            colors = {
                magenta = '#bb9af7',
                purple = '#9d7cd8',
            },
            style = c.styles[style],
        })

        for t_name, u_name in pairs(c.overrides[style]) do
            if not self['_' .. style][t_name] then
                error('Invalid tokyonight color: "' .. t_name .. '".')
            end

            if not _scheme[style][u_name] then
                error('Color "' .. u_name .. '" in user scheme "' .. c.scheme .. '".')
            end

            self['_' .. style][t_name] = _scheme[style][u_name]
        end
    end

    return setmetatable(self, UserScheme)
end

function UserScheme:update(dark)
    vim.o.background = dark and 'dark' or 'light'

    vim.g.tokyonight_italic_comments = default_tokyopts.tokyonight_italic_comments
    vim.g.tokyonight_italic_functions = default_tokyopts.tokyonight_italic_functions
    vim.g.tokyonight_italic_comments = default_tokyopts.tokyonight_italic_comments
    vim.g.tokyonight_transparent = default_tokyopts.tokyonight_transparent
    vim.g.tokyonight_transparent_sidebar = default_tokyopts.tokyonight_transparent_sidebar
    vim.g.tokyonight_sidebars = default_tokyopts.tokyonight_sidebars
    vim.g.tokyonight_style = self:getStyle(dark)
    vim.g.tokyonight_colors = self:getColors(dark)

    vim.cmd([[colorscheme tokyonight]])
end

function UserScheme:initAutocommand()
    vim.api.nvim_create_autocmd('Signal', {
        pattern = 'SIGUSR1',
        callback = function()
            self:update(OSDarkmodeEnabled())
        end,
    })
end

function UserScheme:init()
    if loaded == true then
        return self
    end

    self:update(OSDarkmodeEnabled())
    self:initAutocommand()

    return self
end

function UserScheme:getStyle(dark)
    if dark == nil then
        dark = DarkmodeEnabled()
    end

    return dark and self._styles.dark or self._styles.light
end

function UserScheme:getColors(dark)
    dark = dark or DarkmodeEnabled()

    return self[dark and '_dark' or '_light']
end

function UserScheme:getUserColors(dark)
    if dark == nil then
        dark = DarkmodeEnabled()
    end

    return dark and self._userscheme.dark or self._userscheme.light
end

function UserScheme:getConfig()
    return self._config
end

local function default_overrides()
    return _default_overrides
end

local function default_config()
    local c = config
    c.overrides.dark = default_overrides()
    c.overrides.light = default_overrides()

    return config
end

local function merge_userconfig(opts)
    if opts ~= nil then
        user_config = vim.tbl_deep_extend('force', default_config(), opts or {})
    end

    return user_config
end

function M.config(default)
    if default == true or user_config == nil or loaded == false then
        return default_config()
    end

    return user_config
end

function M.setup(opts)
    if loaded then
        return loaded_scheme
    end

    loaded_scheme = UserScheme.create(merge_userconfig(opts))
    loaded_scheme:init()

    vim.api.nvim_create_autocmd('Signal', { pattern = 'SIGUSR1', command = 'PackerCompile' })
    util.kmap('CS', '<cmd>lua require("scheme").toggle()<CR>', 'n', { noremap = true })

    loaded = true

    return loaded_scheme
end

function M.toggle()
    loaded_scheme:update(vim.o.background ~= 'dark')
end

M.utils = util

return M
