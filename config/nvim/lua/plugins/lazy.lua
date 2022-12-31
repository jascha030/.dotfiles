return {
    { dir = '~/.development/Projects/Lua/nitepal.nvim' },
    'kyazdani42/nvim-web-devicons',
    'yamatsum/nvim-nonicons',
    'nvim-lua/plenary.nvim',
    'noib3/nvim-cokeline',
    'voldikss/vim-floaterm',
    'ojroques/vim-oscyank',
    'hoob3rt/lualine.nvim',
    'kyazdani42/nvim-tree.lua',
    'sheerun/vim-polyglot',
    {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('indent_blankline').setup({
                filetype_exclude = { 'dashboard' },
            })
        end,
    },
    'f-person/git-blame.nvim',
    'wakatime/vim-wakatime',
    { 'akinsho/toggleterm.nvim', version = '*' },
    {
        'phaazon/hop.nvim',
        branch = 'v2',
        config = function()
            require('hop').setup({
                keys = 'etovxqpdygfblzhckisuran',
                jump_on_sole_occurrence = false,
            })
        end,
    },
    'goolord/alpha-nvim',
    'ziontee113/icon-picker.nvim',
    'gelguy/wilder.nvim',
    'yamatsum/nvim-cursorline',
    {
        'luukvbaal/stabilize.nvim',
        config = true,
    },
    {
        'terrortylor/nvim-comment',
        config = function()
            require('nvim_comment').setup()
        end,
    },
    {
        'petertriho/nvim-scrollbar',
        config = function()
            require('scrollbar').setup({})
        end,
    },
    {
        'folke/which-key.nvim',
        config = {},
    },
    {
        'ziontee113/color-picker.nvim',
        config = {},
    },
    {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup()
        end,
    },
    {
        'windwp/nvim-autopairs',
        config = {},
    },
    {
        'zbirenbaum/neodim',
        event = 'LspAttach',
        config = function()
            require('neodim').setup({
                alpha = 0.75,
                blend_color = '#000000',
                update_in_insert = { enable = true, delay = 100 },
                hide = { virtual_text = true, signs = true, underline = true },
            })
        end,
    },
}
