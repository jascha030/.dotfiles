---@type LazyPluginSpec[]
local M = {
    { 'wakatime/vim-wakatime' },
    { 'f-person/git-blame.nvim' },
    {
        'lvimuser/lsp-inlayhints.nvim',
        opts = {
            inlay_hints = {
                parameter_hints = {
                    show = true,
                    prefix = '<-- ',
                    separator = ', ',
                    remove_colon_start = false,
                    remove_colon_end = true,
                },
                type_hints = {
                    show = true,
                    prefix = ': ',
                    separator = ', ',
                    remove_colon_start = false,
                    remove_colon_end = false,
                },
                only_current_line = true,
                labels_separator = '  ',
                max_len_align = true,
                max_len_align_padding = 1,
                highlight = 'LspInlayHint',
                priority = 0,
            },
        },
    },
    { 'chr4/nginx.vim', ft = 'nginx' },
    { 'b0o/schemastore.nvim', ft = { 'json', 'yaml', 'yml' } },
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
    { 'justinsgithub/wezterm-types' },
}

return M
