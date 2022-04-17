return require('packer').startup(function(use)
    -- Packer
    use({ 'wbthomason/packer.nvim' })

    -- Impatient should be first plugin after packer.
    use({ 'lewis6991/impatient.nvim', config = [[require('impatient')]] })

    -- Language/syntax
    --
    -- LSP
    use({
        'neovim/nvim-lspconfig',
        'williamboman/nvim-lsp-installer',
    })
    use({ 'onsails/lspkind-nvim' })
    use({ 'jose-elias-alvarez/null-ls.nvim' })

    -- Cmp
    use({ 'hrsh7th/nvim-cmp' })
    use({ 'hrsh7th/cmp-nvim-lsp' })
    use({ 'hrsh7th/cmp-path' })
    use({ 'hrsh7th/cmp-buffer' })
    use({ 'hrsh7th/cmp-vsnip' })

    -- Snippet engine/completion
    use({ 'L3MON4D3/LuaSnip' })
    use({ 'saadparwaiz1/cmp_luasnip' })
    use({ 'simrat39/rust-tools.nvim' })
    use({ 'ncm2/ncm2' })

    -- Visual/UI components
    --
    -- Startup screen
    use({
        'goolord/alpha-nvim',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            require('alpha').setup(require('alpha.themes.startify').opts)
        end,
    })

    -- Telescope
    use({
        'nvim-telescope/telescope.nvim',
        requires = {
            { 'nvim-lua/popup.nvim' },
            { 'nvim-lua/plenary.nvim' },
        },
    })
    use({ 'nvim-telescope/telescope-file-browser.nvim' })
    use({ 'nvim-telescope/telescope-fzy-native.nvim' })

    -- Treesitter
    use({ 'nvim-treesitter/nvim-treesitter-textobjects' })
    use({ 'nvim-treesitter/nvim-treesitter', irun = ':TSUpdate' })
    use({ 'nvim-treesitter/playground' })
    use({ 'p00f/nvim-ts-rainbow' })

    use({ 'karb94/neoscroll.nvim' })
    use({ 'kyazdani42/nvim-tree.lua' })
    use({ 'petertriho/nvim-scrollbar' })
    use({ 'voldikss/vim-floaterm' })
    use({
        'noib3/nvim-cokeline',
        requires = 'kyazdani42/nvim-web-devicons',
    })
    use({
        'hoob3rt/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    })

    -- Theme
    use({ 'tjdevries/colorbuddy.nvim' })
    use({ 'norcalli/nvim-colorizer.lua' })
    use({ 'marko-cerovac/material.nvim' })
    use({ 'folke/tokyonight.nvim' })

    -- Other
    use({ 'mfussenegger/nvim-dap' })
    use({ 'ojroques/vim-oscyank' })
    use({ 'phaazon/hop.nvim', branch = 'v1' })
    use({ 'wakatime/vim-wakatime' })
    -- use { 'terryma/vim-multiple-cursors' }
end)
