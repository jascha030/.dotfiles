vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

local phpactor_commands = {
    'PhpActor context_menu',
    'PhpActor class_inflect',
    'PhpActor config',
    'PhpActor copy_class',
    'PhpActor expand_class',
    'PhpActor generate_accessor',
    'PhpActor change_visibility',
    'PhpActor import_class',
    'PhpActor import_missing_classes',
    'PhpActor move_class',
    'PhpActor navigate',
    'PhpActor new_class',
    'PhpActor status',
    'PhpActor transform',
    'PhpActor update',
    'PhpActor cache_clear',
}

vim.keymap.set('n', '<leader>pn', ':PhpactorClassNew<CR>')
vim.keymap.set('n', '<leader>pm', ':PhpactorContextMenu<CR>')
vim.keymap.set('n', '<leader>pp', function()
    vim.ui.select(phpactor_commands, { prompt = 'PhpActor' }, function(choice)
        if choice then
            vim.cmd(choice)
        end
    end)
end)
