---@type LazyPluginSpec[]
local M = {
    { 'wakatime/vim-wakatime' },
    { 'chr4/nginx.vim', ft = 'nginx' },
    { 'b0o/schemastore.nvim', ft = { 'json', 'yaml', 'yml' } },
    {
        'saecki/crates.nvim',
        event = { 'BufRead Cargo.toml' },
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = true,
        lazy = true,
    },
    { 'justinsgithub/wezterm-types' },
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
