---@type LazyPluginSpec
local M = {
    'adalessa/laravel.nvim',
    cond = false, -- @todo: add condition
    dependencies = {
        'nvim-telescope/telescope.nvim',
        'tpope/vim-dotenv',
        'MunifTanjim/nui.nvim',
    },
    event = { 'VeryLazy' },
    cmd = { 'Sail', 'Artisan', 'Composer', 'Npm', 'Yarn', 'Laravel' },
    keys = {
        {
            '<leader>lt',
            function()
                require('laravel.tinker').send_to_tinker()
            end,
            mode = 'v',
            desc = 'Laravel Application Routes',
        },
        { '<leader>la', '<cmd>Laravel artisan<cr>' },
        { '<leader>lr', '<cmd>Laravel routes<cr>' },
        { '<leader>lm', '<cmd>Laravel related<cr>' },
    },
    config = function(_, opts)
        require('laravel').setup(opts)
        require('telescope').load_extension('laravel')
    end,
}

return M
