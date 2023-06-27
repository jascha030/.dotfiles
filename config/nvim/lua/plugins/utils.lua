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
    {
        'folke/which-key.nvim',
        config = function()
            local keymaps = require('utils.conf').keymaps
            local wk = require('which-key')

            for mtype, tmaps in pairs(keymaps) do
                local results = {}

                for kmap, args in pairs(tmaps) do
                    results[kmap] = { args[1], args[1] }
                end

                wk.register(results, { nowait = true, mode = mtype })
            end
        end,
    },
}
