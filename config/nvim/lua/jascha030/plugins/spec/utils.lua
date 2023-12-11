return {
    'wakatime/vim-wakatime',
    'f-person/git-blame.nvim',
    { 'ojroques/vim-oscyank' },
    { 'nvim-lua/plenary.nvim', lazy = true },
    { 'ziontee113/color-picker.nvim', lazy = true },
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
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
