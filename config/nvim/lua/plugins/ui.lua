return {
    {
        dir = '~/.development/Projects/Lua/nitepal.nvim',
        dependencies = { 'hoob3rt/lualine.nvim' },
    },
    'goolord/alpha-nvim',
    {
        'gelguy/wilder.nvim',
        config = function()
            local wilder = require('wilder')

            wilder.setup({ modes = { ':', '?' } })
            wilder.set_option(
                'renderer',
                wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
                    highlights = { border = 'Normal' },
                    border = 'rounded',
                }))
            )
        end,
    },
    'kyazdani42/nvim-tree.lua',
    'sheerun/vim-polyglot',
    {
        'yamatsum/nvim-cursorline',
        config = {
            cursorline = {
                enable = true,
                timeout = 1000,
                number = false,
            },
            cursorword = {
                enable = true,
                min_length = 3,
                hl = { underline = true },
            },
        },
    },
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
