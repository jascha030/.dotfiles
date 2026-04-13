---@diagnostic disable: duplicate-set-field
local darkmode = lreq('darkmode')
local DARK = 'dark'
local LIGHT = 'light'

--- @class ThemeUtil
local M = {}
local loaded = false

local function do_update_autocmd()
    vim.cmd([[doautocmd <nomodeline> User NitePalUpdateScheme]])
end

---@return boolean
function M.is_dark()
    return vim.o.background == DARK
end

---@param mode string
function M.update(mode)
    local cs = require('jascha030.core.config').options.colorscheme

    if cs == 'nitepal' or cs == 'litepal' then
        require('nitepal.config').options.style = mode
    end

    --- Don't set vim.o.background here — nitepal.colorscheme() handles it.
    --- Setting it separately fires lualine's `OptionSet background` autocmd
    --- *before* the colorscheme is applied, causing lualine to rebuild its
    --- highlight groups from a half-stale state. Let the colorscheme command
    --- be the single mutation point.
    if mode == DARK then
        vim.cmd([[colorscheme nitepal]])
    else
        vim.cmd([[colorscheme litepal]])
    end

    do_update_autocmd()
end

function M.toggle()
    M.update(M.is_dark() and LIGHT or DARK)
end

function M.set_from_os()
    M.update(darkmode.enabled() and DARK or LIGHT)
end

function M.get_background()
    return M.is_dark() and '#1e2030' or '#e7e9ef'
end

function M.init()
    if loaded == true then
        return
    end

    loaded = true;

    (function()
        vim.opt.runtimepath:prepend(os.getenv('XDG_CONFIG_HOME'))

        vim.keymap.set('n', 'CS', M.toggle, { noremap = true })

        -- Auto change colorscheme on MacOS Light/Darkmode change.
        vim.api.nvim_create_autocmd('Signal', {
            pattern = 'SIGUSR1',
            callback = M.set_from_os,
        })

        vim.o.background = darkmode.enabled() and DARK or LIGHT

        M.set_from_os()
    end)()
end

return M
