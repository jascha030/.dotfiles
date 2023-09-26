return {
    'wakatime/vim-wakatime',
    'f-person/git-blame.nvim',
    { 'ojroques/vim-oscyank' },
    { 'nvim-lua/plenary.nvim', lazy = true },
    { 'ziontee113/color-picker.nvim', lazy = true },
    { 'windwp/nvim-autopairs', config = true },
    { 'petertriho/nvim-scrollbar', config = true },
    { 'luukvbaal/stabilize.nvim', config = true },
    {
        'zbirenbaum/copilot.lua',
        cmd = 'Copilot',
        dependencies = 'nvim-lspconfig',
        event = 'VimEnter',
        config = function(_, _)
            require('copilot').setup()
        end,
    },
    {
        'saecki/crates.nvim',
        event = { 'BufRead Cargo.toml' },
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = true,
        lazy = true,
    },
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
        opts = {
            filetype_exclude = { 'dashboard' },
            show_current_context = true,
            show_current_context_start = true,
        },
    },
    {
        'terrortylor/nvim-comment',
        name = 'nvim_comment',
        config = true,
    },
    {
        'folke/trouble.nvim',
        cmd = {
            'Trouble',
            'TroubleClose',
            'TroubleToggle',
            'TroubleRefresh',
        },
        opts = {
            position = 'bottom',
            win_config = {
                border = BORDER,
            },
            use_diagnostic_signs = true,
        },
    },
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        config = function(_, _)
            local keymaps = require('jascha030.config').options.keymaps
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
    {
        'ziontee113/icon-picker.nvim',
        cond = false,
    },
}
