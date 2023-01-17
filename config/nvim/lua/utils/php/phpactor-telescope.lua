local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local conf = require('telescope.config').values

local picker = function()
    if vim.bo.filetype ~= 'php' then
        return
    end
    pickers
        .new({
            prompt_title = 'Phpactor',
            finder = finders.new_table({
                results = {
                    'PhpactorExtractMethod',
                    'PhpactorExtractExpression',
                    'PhpactorExtractConstant',
                    'PhpactorImportClass',
                    'PhpactorImportMissingClasses',
                    'PhpactorHover',
                    'PhpactorContextMenu',
                    'PhpactorCopyFile',
                    'PhpactorMoveFile',
                    'PhpactorClassInflect',
                    'PhpactorFindReferences',
                    'PhpactorNavigate',
                    'PhpactorChangeVisibility',
                    'PhpactorGenerateAccessors',
                    'PhpactorTransform',
                    'PhpactorUpdate',
                    'PhpactorCacheClear',
                    'PhpactorStatus',
                    'PhpactorConfig',
                    'PhpactorExtensionList',
                    'PhpactorExtensionInstall',
                    'PhpactorExtensionRemove',
                    'PhpactorClassExpand',
                    'PhpactorClassNew',
                    'PhpactorGotoDefinition',
                    'PhpactorGotoDefinitionVsplit',
                    'PhpactorGotoDefinitionHsplit',
                    'PhpactorGotoDefinitionTab',
                    'PhpactorGotoType',
                    'PhpactorGotoImplementations',
                },
            }),
            sorter = conf.generic_sorter(),
            attach_mappings = function(prompt_buff, map)
                actions.select_default:replace(function()
                    actions.close(prompt_buff)
                    vim.api.nvim_command(action_state.get_selected_entry()[1])
                end)
                return true
            end,
        })
        :find()
end

return {
    picker = picker,
}
