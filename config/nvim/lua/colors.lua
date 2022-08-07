if not require('utils').validate({ 'tokyonight', 'shell', 'darkmode' }, 'colors.lua') then
    return
end

local darkmode = require('darkmode')
local config = require('colors.config')

local M = {}
local DARK = 'dark'
local LIGHT = 'light'
local loaded, user_config = false, {}

function M.is_dark()
    return vim.o.background == DARK
end

function M.update(mode)
    vim.o.background = mode

    for index, value in pairs(user_config.options) do
        vim.g[index] = value
    end

    vim.g.tokyonight_style = user_config.styles[mode]
    vim.g.tokyonight_colors = user_config.colors[mode]
    vim.cmd([[colorscheme tokyonight]])
end

function M.toggle()
    M.update(M.is_dark() and LIGHT or DARK)
end

local function merge_userconfig(opts)
    local conf = config.get_default()

    return vim.tbl_deep_extend('force', conf, opts or {})
end

local function auto_commands()
    vim.api.nvim_create_autocmd('Signal', {
        pattern = 'SIGUSR1',
        callback = function()
            M.update(darkmode.enabled() and DARK or LIGHT)
        end,
    })

    vim.api.nvim_create_autocmd('Signal', {
        pattern = 'SIGUSR1',
        command = 'PackerCompile',
    })
end

function M.get_colors()
    return user_config.colors[vim.o.background]
end

function M.init()
    if loaded == true then
        return
    end
    loaded = true

    auto_commands()
    vim.keymap.set('n', 'CS', function()
        M.toggle()
    end, { noremap = true })

    M.update(darkmode.enabled() and DARK or LIGHT)
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
