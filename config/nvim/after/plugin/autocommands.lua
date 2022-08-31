local utils = require('utils')

vim.api.nvim_create_autocmd('Signal', {
    pattern = 'SIGUSR1',
    callback = function()
        utils.theme.set_from_os()
    end,
})

vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = 'nitepal',
    callback = function ()
        utils.icons.setup(utils.conf.devicons)
    end
})

