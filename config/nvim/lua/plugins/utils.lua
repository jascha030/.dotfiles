return {
    'github/copilot.vim',
    'nvim-lua/plenary.nvim',
    'wakatime/vim-wakatime',
    'ojroques/vim-oscyank',
    'f-person/git-blame.nvim',
    {
        'phaazon/hop.nvim',
        branch = 'v2',
        name = 'hop',
        config = {
            keys = 'etovxqpdygfblzhckisuran',
            jump_on_sole_occurrence = false,
        },
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        namme = 'indent_blankline',
        config = { filetype_exclude = { 'dashboard' } },
    },
    {
        'zbirenbaum/neodim',
        event = 'LspAttach',
        config = {
            alpha = 0.75,
            blend_color = '#000000',
            update_in_insert = { enable = true, delay = 100 },
            hide = { virtual_text = true, signs = true, underline = true },
        },
    },
    { 'ziontee113/icon-picker.nvim', config = {} },
    { 'ziontee113/color-picker.nvim', config = {} },
    { 'terrortylor/nvim-comment', name = 'nvim_comment', config = true },
    { 'folke/which-key.nvim', config = {} },
    { 'windwp/nvim-autopairs', config = {} },
    { 'petertriho/nvim-scrollbar', config = true },
    { 'luukvbaal/stabilize.nvim', config = true },
}
