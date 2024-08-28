vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.softtabstop = 4
vim.o.shiftwidth = 4

vim.keymap.set('n', '<leader>pn', ':PhpactorClassNew<CR>')
vim.keymap.set('n', '<leader>pm', ':PhpactorContextMenu<CR>')
vim.keymap.set('n', '<leader>pp', function()
    local pickers = lreq('telescope.pickers')
    local finders = lreq('telescope.finders')
    local actions = lreq('telescope.actions')
    local action_state = lreq('telescope.actions.state')
    local conf = lreq('telescope.config').values

    pickers
        .new({
            prompt_title = 'PhpActor',
            finder = finders.new_table({
                results = {
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
                },
            }),
            sorter = conf.generic_sorter(),
            attach_mappings = function(prompt_buff, _)
                actions.select_default:replace(function()
                    actions.close(prompt_buff)
                    vim.api.nvim_command(action_state.get_selected_entry()[1])
                end)
                return true
            end,
        }, {})
        :find()
end)
