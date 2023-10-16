local M = {}

local config = require('jascha030.config')

-- Just having some fun exploring lua "lazyloading"
local utils = {}

-- stylua: ignore
utils = setmetatable(utils, { __index = function(_, k)
    return vim.tbl_isempty(utils)
            and (function()
                utils = require('jascha030.utils')
                return utils[k] or nil
            end)()
        or nil
end })

function M.setup(options)
    config.setup(options or {})

    vim.cmd([[
        set termguicolors
        set t_Co=256
    ]])

    utils.keymaps.set_keymaps(config.options.keymaps)
    utils.opts.set_opts(config.options.opts)

    require('jascha030.lazy')

    -- Fix for the fact that n is bound to q, and I can't seem to find the source of this... :thinking_emoji:
    vim.keymap.set('n', 'n', 'n')

    ---@diagnostic disable-next-line: undefined-field, need-check-nil
    require('jascha030.config.devicons').setup(config.options.devicons)
    require('nvim-web-devicons').set_up_highlights()
end

return setmetatable(M, {
    __index = function(_, key)
        return (key == 'options' or key == 'config') and config.options or nil
    end,
})
