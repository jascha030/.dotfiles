local M = {}

local config = require('jascha030.config')




function M.get_config(key)
    return key == nil and config.options or config.get(key)
end

function M.setup(opts)
    config.setup(opts)
    require('jascha030.config.keymaps').set_keymaps(config.get('keymaps'))
    require('jascha030.config.options').set_opts(config.get('opts'))

    ---@diagnostic disable-next-line
    require('jascha030.lazy')

    -- Fix for the fact that n is bound to q, and I can't seem to find the source of this... :thinking_emoji:
    vim.keymap.set('n', 'n', 'n')
end

return setmetatable(M, {
    __index = function(_, key)
        if key == 'options' or key == 'opts' or key == 'config' then
            return config.options
        end

        return M.get_option(key)
    end,
})
