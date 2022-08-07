local utils = require('utils')
local dependencies = {
    'tokyonight',
    'shell',
    'darkmode',
}

if not utils.validate(dependencies, 'colors.lua') then
    return
end

local M = {}

local loaded = false
local user_config = {}

local DARK = 'dark'
local LIGHT = 'light'

local darkmode = require('darkmode')
local config = require('colors.config')

local function get_mode()
    return vim.o.background
end

function M.is_dark()
    return get_mode() == DARK
end

function M.os_is_dark()
    return (darkmode.enabled()):find('dark') ~= nil
end

function M.update()
    local mode = M.is_dark() and DARK or LIGHT

    local colors = user_config.colors[mode]
    local style = user_config.styles[mode]

    for index, value in pairs(user_config.options) do
        vim.g[index] = value
    end

    vim.g.tokyonight_style = style
    vim.g.tokyonight_colors = colors

    vim.cmd([[colorscheme tokyonight]])
end

function M.set(mode)
    local dark = (mode == DARK)

    if M.is_dark() == dark then
        return
    end

    vim.o.background = mode

    M.update()
end

function M.toggle()
    M.set(M.is_dark() and LIGHT or DARK)
end

local function merge_userconfig(opts)
    local conf = config.get_default()

    if opts ~= nil then
        conf = vim.tbl_deep_extend('force', conf, opts or {})
    end

    return conf
end

local function auto_commands()
    vim.api.nvim_create_autocmd('Signal', {
        pattern = 'SIGUSR1',
        callback = M.update,
    })

    vim.api.nvim_create_autocmd('Signal', {
        pattern = 'SIGUSR1',
        command = 'PackerCompile',
    })
end

function M.init()
    if loaded == true then
        return
    end

    loaded = true

    M.update()
    auto_commands()

    utils.kmap('CS', '<cmd>lua require("colors").toggle()<CR>', 'n', { noremap = true })
end

function M.setup(conf)
    if loaded == true then
        return
    end

    conf = conf or config.get_default()
    user_config = config.generate(merge_userconfig(conf))

    M.init()
end

return M
