local utils = nil

vim.api.nvim_create_autocmd('Signal', {
    pattern = 'SIGUSR1',
    callback = function()
        if utils == nil then
            utils = require('utils')
        end

        utils.theme.set_from_os()
    end,
})

vim.cmd([[autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]])

