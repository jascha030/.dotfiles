local utils = require('utils')
local config = utils.conf

require('nitepal.config').extend({
    transparent = {
        background = true,
        floats = true,
        popups = true,
        sidebars = true,
    },
    contrast = true,
})

if config.colorscheme == 'nitepal' then
    utils.theme.init()
else
    vim.cmd('colorscheme ' .. config.colorscheme)
end

vim.api.nvim_create_autocmd('Signal', {
    pattern = 'SIGUSR1',
    callback = function()
        if utils == nil then
            utils = require('utils')
        end

        utils.theme.set_from_os()

        require('config.loader').load_all()
    end,
})
