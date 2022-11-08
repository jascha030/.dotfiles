vim.o.confirm = true
vim.api.nvim_create_autocmd('BufEnter', {
    group = vim.api.nvim_create_augroup('NvimTreeClose', { clear = true }),
    callback = function()
        local layout = vim.api.nvim_call_function('winlayout', {})

        if
            layout[1] == 'leaf'
            and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), 'filetype') == 'NvimTree'
            and layout[3] == nil
        then
            vim.cmd('quit')
        end
    end,
})
