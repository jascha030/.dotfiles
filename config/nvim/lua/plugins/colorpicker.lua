return function()
    local opts = { noremap = true, silent = true }

    vim.keymap.set('n', '<C-p><C-p>', '<cmd>PickColor<cr>', opts)
    vim.keymap.set('i', '<C-p><C-p>', '<cmd>PickColorInsert<cr>', opts)

    require('color-picker').setup({})
end
