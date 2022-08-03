-- TODO: bigi refactro loco.
-- local M = {}

local ui = require('plugins.ui')
local utils = require('plugins.utils')
local lsp = require('plugins.lsp')

-- Auto commands
vim.cmd([[autocmd BufWritePost plugins.lua PackerCompile]])
vim.cmd([[packadd packer.nvim]], false)

require('packer').startup({
    function(use)
        use({ 'wbthomason/packer.nvim' })
        --use({ 'lewis6991/impatient.nvim', config = [[require('impatient')]] })
        use({ 'kyazdani42/nvim-web-devicons', config = require('plugins.devicons') })
        use({ 'yamatsum/nvim-nonicons', requires = 'kyazdani42/nvim-web-devicons' })
        use({ 'goolord/alpha-nvim', config = utils.alpha })

        -- Language/syntax/LSP
        use({
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'neovim/nvim-lspconfig',
        })

        use({ 'onsails/lspkind-nvim' })
        use({ 'jose-elias-alvarez/null-ls.nvim' })
        use({ 'hrsh7th/nvim-cmp', config = lsp.cmp })
        use({ 'hrsh7th/cmp-nvim-lsp' })
        use({ 'hrsh7th/cmp-path' })
        use({ 'hrsh7th/cmp-buffer' })
        use({ 'hrsh7th/cmp-vsnip' })
        use({ 'L3MON4D3/LuaSnip' })
        use({ 'saadparwaiz1/cmp_luasnip' })
        use({ 'simrat39/rust-tools.nvim' })
        use({ 'ncm2/ncm2' })
        use({ 'j-hui/fidget.nvim', config = utils.fidget })

        use({ 'mfussenegger/nvim-dap' })
        use({
            'folke/trouble.nvim',
            requires = 'kyazdani42/nvim-web-devicons',
            config = lsp.trouble,
        })
        use({
            'folke/which-key.nvim',
            config = function()
                require('which-key').setup({})
            end,
        })

        -- Visual/UI components
        -- Telescope
        use({
            'nvim-telescope/telescope.nvim',
            requires = {
                { 'nvim-lua/popup.nvim' },
                { 'nvim-lua/plenary.nvim' },
            },
            config = utils.telescope,
        })
        use({ 'nvim-telescope/telescope-file-browser.nvim' })
        use({ 'nvim-telescope/telescope-fzy-native.nvim' })
        use({ 'nvim-telescope/telescope-ui-select.nvim' })
        use({ 'ziontee113/color-picker.nvim', config = utils.color_picker })
        use({ 'filipdutescu/renamer.nvim', branch = 'master', requires = { { 'nvim-lua/plenary.nvim' } } })

        -- Treesitter
        use({ 'nvim-treesitter/nvim-treesitter-textobjects' })
        use({ 'nvim-treesitter/playground' })
        use({ 'p00f/nvim-ts-rainbow' })
        use({ 'nvim-treesitter/nvim-treesitter', irun = ':TSUpdate', config = utils.treesitter })
        use({ 'voldikss/vim-floaterm' })
        use({ 'kyazdani42/nvim-tree.lua', config = require('plugins.tree') })
        use({ 'petertriho/nvim-scrollbar', config = ui.scrollbar })
        use({ 'noib3/nvim-cokeline', config = ui.cokeline })
        use({ 'hoob3rt/lualine.nvim', config = ui.lualine })
        use({ 'is0n/fm-nvim' })

        -- Theme
        use({ 'tjdevries/colorbuddy.nvim' })
        use({ 'norcalli/nvim-colorizer.lua', config = ui.colorizer })
        use({ 'marko-cerovac/material.nvim' })
        use({ 'folke/tokyonight.nvim' })

        -- Other
        use({ 'karb94/neoscroll.nvim' })
        use({ 'ojroques/vim-oscyank' })
        use({ 'phaazon/hop.nvim', branch = 'v1', config = utils.hop })
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
