return {
    -- 'github/copilot.vim',
    {
        'zbirenbaum/copilot.lua',
        cmd = 'Copilot',
        dependencies = { 'nvim-lspconfig' },
        event = { 'VimEnter' },
        config = function()
            require('copilot').setup()
        end,
    },
    'nvim-lua/plenary.nvim',
    'wakatime/vim-wakatime',
    'ojroques/vim-oscyank',
    'f-person/git-blame.nvim',
    {
        'phaazon/hop.nvim',
        branch = 'v2',
        name = 'hop',
        opts = {
            keys = 'etovxqpdygfblzhckisuran',
            jump_on_sole_occurrence = false,
        },
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        name = 'indent_blankline',
        opts = { filetype_exclude = { 'dashboard' } },
    },
    { 'ziontee113/icon-picker.nvim', opts = {} },
    { 'ziontee113/color-picker.nvim', opts = {} },
    { 'terrortylor/nvim-comment', name = 'nvim_comment', config = true },
    { 'windwp/nvim-autopairs', opts = {} },
    { 'petertriho/nvim-scrollbar', config = true },
    { 'luukvbaal/stabilize.nvim', config = true },
}
