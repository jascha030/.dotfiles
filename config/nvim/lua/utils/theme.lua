local darkmode = require('darkmode')

local M = {}
local DARK = 'dark'
local LIGHT = 'light'

local loaded = false

function M.is_dark()
    return vim.o.background == DARK
end

function M.update(mode)
    vim.o.background = mode

    vim.cmd([[colorscheme nitepal]])
end

function M.toggle()
    M.update(M.is_dark() and LIGHT or DARK)
end

local function autocmds()
    vim.api.nvim_create_autocmd('Signal', {
        pattern = 'SIGUSR1',
        callback = function()
            M.update(darkmode.enabled() and DARK or LIGHT)
        end,
    })
end

function M.init()
    if loaded == true then
        return
    end

    loaded = true

    autocmds()

    vim.keymap.set('n', 'CS', function()
        M.toggle()
    end, { noremap = true })

    M.update(darkmode.enabled() and DARK or LIGHT)
end

return M
