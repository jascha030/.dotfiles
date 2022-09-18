local M = {}
local DARK = 'dark'
local LIGHT = 'light'

local loaded = false
local darkmode = nil

function M.is_dark()
    return vim.o.background == DARK
end

function M.update(mode)
    local cs = require('utils').conf.colorscheme

    if vim.o.background ~= mode then
        if cs == 'nitepal' or cs == 'litepal' then
            require('nitepal.config').options.style = mode
        end

        vim.o.background = mode
    end

    vim.cmd([[colorscheme nitepal]])
end

function M.toggle()
    M.update(M.is_dark() and LIGHT or DARK)
end

function M.set_from_os()
    if not darkmode then
        darkmode = require('darkmode')
    end

    M.update(darkmode.enabled() and DARK or LIGHT)
end

function M.init()
    if loaded == true then
        return
    end

    loaded = true

    vim.keymap.set('n', 'CS', function()
        M.toggle()
    end, { noremap = true })

    M.set_from_os()
end

return M
