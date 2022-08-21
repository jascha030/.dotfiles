return function(use)
    use({ 'wbthomason/packer.nvim' })
    --use({ 'lewis6991/impatient.nvim', config = [[require('impatient')]] })

    use({ 'kyazdani42/nvim-web-devicons', config = require('plugins.devicons') })
    use({ 'yamatsum/nvim-nonicons', requires = 'kyazdani42/nvim-web-devicons' })
    use({ 'goolord/alpha-nvim', config = require('plugins.alpha-nvim') })

    -- Language/syntax/LSP
    use({
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig',
    })

    use({ 'onsails/lspkind-nvim' })
    use({ 'jose-elias-alvarez/null-ls.nvim' })
    use({ 'hrsh7th/nvim-cmp', config = require('plugins.nvim-cmp') })
    use({ 'hrsh7th/cmp-nvim-lsp' })
    use({ 'hrsh7th/cmp-path' })
    use({ 'hrsh7th/cmp-buffer' })
    use({ 'hrsh7th/cmp-vsnip' })
    use({ 'L3MON4D3/LuaSnip' })
    use({ 'saadparwaiz1/cmp_luasnip' })
    use({ 'simrat39/rust-tools.nvim' })
    use({ 'ncm2/ncm2' })
    use({ 'mfussenegger/nvim-dap' })
    use({ 'j-hui/fidget.nvim', config = require('plugins.fidget') })
    use({ 'folke/trouble.nvim', requires = 'kyazdani42/nvim-web-devicons', config = require('plugins.trouble') })
    use({ 'folke/which-key.nvim', config = [[require('which-key').setup({})]] })

    -- Telescope
    use({
        {
            'nvim-telescope/telescope.nvim',
            requires = {
                'nvim-lua/popup.nvim',
                'nvim-lua/plenary.nvim',
                'nvim-telescope/telescope-fzy-native.nvim',
                'nvim-telescope/telescope-ui-select.nvim',
            },
            wants = {
                'popup.nvim',
                'plenary.nvim',
                'telescope-fzy-native.nvim',
            },
            config = require('plugins.telescope-nvim'),
            cmd = 'Telescope',
            module = 'telescope',
        },
        { 'nvim-telescope/telescope-file-browser.nvim' },
        { 'nvim-telescope/telescope-fzy-native.nvim' },
        { 'nvim-telescope/telescope-ui-select.nvim' },
    })

    -- Treesitter
    use({ 'nvim-treesitter/nvim-treesitter-textobjects' })
    use({ 'nvim-treesitter/playground' })
    use({ 'p00f/nvim-ts-rainbow' })
    use({ 'nvim-treesitter/nvim-treesitter', irun = ':TSUpdate', config = require('plugins.treesitter') })
    use({ 'kyazdani42/nvim-tree.lua', config = require('plugins.tree') })
    use({ 'petertriho/nvim-scrollbar', config = require('plugins.nvim-scrollbar') })
    use({ 'noib3/nvim-cokeline', config = require('plugins.cokeline') })
    use({ 'hoob3rt/lualine.nvim', config = require('plugins.lualine') })
    use({ 'is0n/fm-nvim' })
    use({ 'ziontee113/color-picker.nvim', config = require('plugins.colorpicker') })
    use({ 'filipdutescu/renamer.nvim', branch = 'master', requires = { { 'nvim-lua/plenary.nvim' } } })

    use({
        'editorconfig/editorconfig-vim',
        setup = function()
            vim.g.EditorConfig_max_line_indicator = ''
            vim.g.EditorConfig_preserve_formatoptions = 1
        end,
    })

    -- Theme
    use({ 'norcalli/nvim-colorizer.lua', config = [[require('colorizer').setup()]] })
    use({ 'tjdevries/colorbuddy.nvim' })
    use({ 'marko-cerovac/material.nvim' })
    use({ 'folke/tokyonight.nvim' })

    -- Other
    use({ 'voldikss/vim-floaterm' })
    use({ 'karb94/neoscroll.nvim' })
    use({ 'ojroques/vim-oscyank' })
    use({ 'phaazon/hop.nvim', branch = 'v1', config = require('plugins.hop') })
    use({ 'terrortylor/nvim-comment', config = [[require('nvim_comment').setup()]] })
    use({ 'wakatime/vim-wakatime' })
end
