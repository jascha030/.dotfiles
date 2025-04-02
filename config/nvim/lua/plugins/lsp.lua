return {
    'williamboman/mason-lspconfig.nvim',
    'ray-x/lsp_signature.nvim',
    'folke/lazydev.nvim',
    'yioneko/nvim-vtsls',
    {
        'nvimdev/lspsaga.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        opts = {
            ui = { border = BORDER },
            lightbulb = { enable = false },
        },
    },
    {
        'simrat39/rust-tools.nvim',
        ft = 'rs',
        dependencies = { 'rust-lang/rust.vim' },
        lazy = true,
    },
    {
        'j-hui/fidget.nvim',
        name = 'fidget',
        tag = 'legacy',
        opts = {
            text = { spinner = 'dots' },
            window = { relative = 'editor', blend = 0, zindex = nil },
            sources = { phpactor = { ignore = true } },
        },
    },
}
