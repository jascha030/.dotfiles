local M = {}

local config = require('jascha030.config')



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
        if key == 'options' or key == 'opts' or key == 'config' then
            return config.options
        end

        return M.get_option(key)
    end,
})
