local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local conf = require('telescope.config').values

local M = {}

function M.picker()
    pickers
        .new({
            prompt_title = 'Phpactor',
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
        })
        :find()
end

return M
