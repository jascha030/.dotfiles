vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

vim.keymap.set('n', '<leader>pn', ':PhpactorClassNew<CR>')
vim.keymap.set('n', '<leader>pm', ':PhpactorContextMenu<CR>')
vim.keymap.set('n', '<leader>pp', function()
    require('jascha030.utils.php.phpactor-telescope').picker()
end)
