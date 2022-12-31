return {
    {
        dir = '~/.development/Projects/Lua/nitepal.nvim',
        dependencies = { 'hoob3rt/lualine.nvim' },
    },
    'goolord/alpha-nvim',
    'gelguy/wilder.nvim',
    'kyazdani42/nvim-tree.lua',
    'sheerun/vim-polyglot',
    'yamatsum/nvim-cursorline',
    {
        'yamatsum/nvim-nonicons',
        dependencies = { 'kyazdani42/nvim-web-devicons' },
    },
    {
        'noib3/nvim-cokeline',
        config = {
            show_if_buffers_are_at_least = 2,
            buffers = {
                focus_on_delete = false,
                new_buffers_position = 'next',
            },
        },
    },
    { 'norcalli/nvim-colorizer.lua', name = 'colorizer', config = true },
}
