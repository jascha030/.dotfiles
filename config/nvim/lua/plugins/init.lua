local cmd = vim.cmd
local config = {
    utils = require('plugins.config.utils'),
    lsp = require('plugins.config.lsp'),
    ui = require('plugins.config.ui'),
}

-- Auto commands
cmd([[autocmd BufWritePost packer.lua PackerCompile]])
cmd([[packadd packer.nvim]], false)

require('packer').startup({
    function(use)
        -- Packer
        use({ 'wbthomason/packer.nvim' })

        -- Impatient should be first plugin after packer.
        use({ 'lewis6991/impatient.nvim', config = [[require('impatient')]] })
        use({
            'yamatsum/nvim-nonicons',
            requires = { 'kyazdani42/nvim-web-devicons' },
        })
        use({ 'goolord/alpha-nvim', config = config.utils.alpha })

        -- Language/syntax
        use({ 'neovim/nvim-lspconfig', 'williamboman/nvim-lsp-installer' })
        use({ 'onsails/lspkind-nvim' })
        use({ 'jose-elias-alvarez/null-ls.nvim' })
        use({ 'hrsh7th/nvim-cmp', config = config.lsp.cmp })
        use({ 'hrsh7th/cmp-nvim-lsp' })
        use({ 'hrsh7th/cmp-path' })
        use({ 'hrsh7th/cmp-buffer' })
        use({ 'hrsh7th/cmp-vsnip' })
        use({ 'L3MON4D3/LuaSnip' })
        use({ 'saadparwaiz1/cmp_luasnip' })
        use({ 'simrat39/rust-tools.nvim' })
        use({ 'ncm2/ncm2' })

        -- Visual/UI components
        -- Telescope
        use({
            'nvim-telescope/telescope.nvim',
            requires = {
                { 'nvim-lua/popup.nvim' },
                { 'nvim-lua/plenary.nvim' },
            },
            config = config.utils.telescope,
        })
        use({ 'nvim-telescope/telescope-file-browser.nvim' })
        use({ 'nvim-telescope/telescope-fzy-native.nvim' })

        -- Treesitter
        use({ 'nvim-treesitter/nvim-treesitter-textobjects' })
        use({ 'nvim-treesitter/playground' })
        use({ 'p00f/nvim-ts-rainbow' })
        use({ 'nvim-treesitter/nvim-treesitter', irun = ':TSUpdate', config = config.utils.treesitter })

        use({ 'voldikss/vim-floaterm' })
        use({ 'kyazdani42/nvim-tree.lua', config = config.ui.tree })
        use({ 'petertriho/nvim-scrollbar', config = config.ui.scrollbar })
        use({ 'noib3/nvim-cokeline', config = config.ui.cokeline })
        use({ 'hoob3rt/lualine.nvim', config = config.ui.lualine })
        use({ 'is0n/fm-nvim' })

        -- Theme
        use({ 'tjdevries/colorbuddy.nvim' })
        use({ 'norcalli/nvim-colorizer.lua', config = config.ui.colorizer })
        use({ 'marko-cerovac/material.nvim' })
        use({ 'folke/tokyonight.nvim' })

        -- Other
        use({ 'karb94/neoscroll.nvim' })
        use({ 'mfussenegger/nvim-dap' })
        use({ 'ojroques/vim-oscyank' })
        use({ 'phaazon/hop.nvim', branch = 'v1', config = config.utils.hop })
        use({ 'wakatime/vim-wakatime' })
    end,
    config = {
        display = {
            open_fn = function()
                return require('packer.util').float({ border = 'single' })
            end,
        },
        profile = {
            enable = true,
            threshold = 1,
        },
    },
})
