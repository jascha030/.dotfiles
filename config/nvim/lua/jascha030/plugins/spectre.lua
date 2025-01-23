---@type LazyPluginSpec
local M = {
    'nvim-pack/nvim-spectre',
    dependencies = { 'nvim-lua/plenary.nvim' },
    build = function(plugin)
        local cmds = {
            ripgrep = { 'brew', 'install', 'ripgrep' },
            sed = { 'brew', 'install', 'gnu-sed' },
        }

        for key, cmd in ipairs(cmds) do
            local obj = vim.system(cmd, { cwd = plugin.dir }):wait()

            if obj.code == 0 then
                vim.notify('Building ' .. key .. ' done', vim.log.levels.INFO)
            else
                vim.notify('Building ' .. key .. ' failed', vim.log.levels.ERROR)
            end
        end
    end,
    keys = {
        {
            '<leader>fs',
            function()
                require('spectre').toggle()
            end,
            desc = 'Toggle Spectre',
        },
        {
            '<leader>sw',
            function()
                require('spectre').open_visual({ select_word = true })
            end,
            desc = 'Search current word',
        },
        {
            '<leader>sp',
            function()
                require('spectre').open_file_search({ select_word = true })
            end,
            desc = 'Search on current file',
        },

        {
            '<leader>sw',
            function()
                require('spectre').open_visual()
            end,
            desc = 'Search current word',
        },
    },
}

return M
