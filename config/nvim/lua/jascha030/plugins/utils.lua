return {
    'wakatime/vim-wakatime',
    'f-person/git-blame.nvim',
    {
        'ojroques/vim-oscyank',
        cmd = {
            'OSCYank',
            'OSCYankReg',
            'OSCYankRegister',
            'OSCYankVisual',
        },
    },
    {
        'nvim-lua/plenary.nvim',
        lazy = true,
    },
    {
        'ziontee113/color-picker.nvim',
        cmd = {
            'PickColor',
            'PickColorInsert',
        },
    },
    {
        'windwp/nvim-autopairs',
        event = { 'InsertEnter' },
        config = true,
    },
    { 'petertriho/nvim-scrollbar', config = true },
    { 'luukvbaal/stabilize.nvim', config = true },
    {
        'saecki/crates.nvim',
        event = { 'BufRead Cargo.toml' },
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = true,
        lazy = true,
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        name = 'indent_blankline',
        main = 'ibl',
        opts = {
            indent = {
                char = '│',
            },
            exclude = {
                filetypes = {
                    'dashboard',
                },
            },
            scope = {
                enabled = true,
            },
        },
    },
    {
        'terrortylor/nvim-comment',
        name = 'nvim_comment',
        config = true,
        event = { 'VeryLazy' },
    },
    {
        'ziontee113/icon-picker.nvim',
        cond = false,
    },
}
