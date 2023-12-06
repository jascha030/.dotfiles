local M = {
    'adalessa/laravel.nvim',
    dependencies = {
        'nvim-telescope/telescope.nvim',
        'tpope/vim-dotenv',
        'MunifTanjim/nui.nvim',
    },
    cmd = { 'Sail', 'Artisan', 'Composer', 'Npm', 'Yarn', 'Laravel' },
    keys = {
        { '<leader>la', '<cmd>Laravel artisan<cr>' },
        { '<leader>lr', '<cmd>Laravel routes<cr>' },
        { '<leader>lm', '<cmd>Laravel related<cr>' },
        {
            '<leader>lt',
            function()
                require('laravel.tinker').send_to_tinker()
            end,
            mode = 'v',
            desc = 'Laravel Application Routes',
        },
    },
    event = { 'VeryLazy' },
    config = function(_, opts)
        require('laravel').setup(opts)
        require('telescope').load_extension('laravel')
    end,
}

return M
