-- {
--     'windwp/nvim-autopairs',
--     event = { 'InsertEnter' },
--     config = true,
-- },

---@type LazyPluginSpec[]
local M = {
    { 'wakatime/vim-wakatime' },
    { 'f-person/git-blame.nvim' },
    { 'chr4/nginx.vim', ft = 'nginx' },
    { 'b0o/schemastore.nvim', ft = { 'json', 'yaml', 'yml' } },
    { 'nvim-lua/plenary.nvim', lazy = true },
    {
        'ziontee113/color-picker.nvim',
        cmd = { 'PickColor', 'PickColorInsert' },
    },
    {
        'kylechui/nvim-surround',
        config = true,
        event = 'VeryLazy',
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
        'terrortylor/nvim-comment',
        name = 'nvim_comment',
        config = true,
        event = { 'VeryLazy' },
    },
    { 'justinsgithub/wezterm-types' },
    {
        'stevearc/conform.nvim',
        config = function(_, _)
            require('jascha030.core.formatting')
        end,
        keys = {
            {
                '<C-l>',
                function()
                    require('conform').format()
                end,
                mode = { 'n', 'v' },
                desc = 'Format using conform.',
            },
        },
    },
    {
        'iamcco/markdown-preview.nvim',
        build = 'cd app && yarn install',
        init = function()
            vim.g.mkdp_filetypes = { 'markdown' }
        end,
        cmd = {
            'MarkdownPreviewToggle',
            'MarkdownPreview',
            'MarkdownPreviewStop',
        },
        ft = { 'markdown' },
        keys = {
            {
                '<leader><leader>mp',
                '<Plug>MarkdownPreview<CR>',
                ft = 'markdown',
                desc = 'Toggle markdown preview',
            },
            {
                '<leader><leader>mt',
                '<Plug>MarkdownPreviewToggle<CR>',
                ft = 'markdown',
                desc = 'Toggle markdown preview',
            },
            {
                '<leader><leader>mq',
                '<Plug>MarkdownPreviewStop<CR>',
                ft = 'markdown',
                desc = 'Stop markdown preview',
            },
        },
    },
}

return M
