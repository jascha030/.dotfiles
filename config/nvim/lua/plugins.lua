local utils = require('utils')

local M = {}

function M.get_config(name, opts)
    local parts = utils.str_explode('/', name)

    name = parts[#parts]
    name = name:gsub('%.nvim', '')

    local m_ok, module = pcall(require, 'plugins.' .. name)

    if not m_ok then
        return function()
            local conf_ok, configuration = pcall(require, name)

            if not conf_ok then
                return
            end

            local ok, _ = pcall(configuration.setup, opts)

            if not ok then
                pcall(configuration.setup)
            end
        end
    end

    return function()
        local ok, _ = pcall(module, opts)

        if not ok then
            pcall(module)
        end
    end
end

-- Auto commands
vim.cmd([[autocmd BufWritePost plugins.lua PackerCompile]])
vim.cmd([[packadd packer.nvim]], false)

local config = {}

require('packer').startup({
    function(use)
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
        use({ 'j-hui/fidget.nvim', config = require('plugins.fidget') })

        use({ 'mfussenegger/nvim-dap' })
        use({
            'folke/trouble.nvim',
            requires = 'kyazdani42/nvim-web-devicons',
            config = require('plugins.trouble'),
        })
        use({
            'folke/which-key.nvim',
            config = function()
                require('which-key').setup({})
            end,
        })

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
        use({ 'nvim-treesitter/nvim-treesitter', irun = ':TSUpdate', config = require('plugins.treesitter') })
        use({ 'kyazdani42/nvim-tree.lua', config = require('plugins.tree') })
        use({ 'petertriho/nvim-scrollbar', config = require('plugins.nvim-scrollbar') })
        use({ 'noib3/nvim-cokeline', config = require('plugins.cokeline') })
        use({ 'hoob3rt/lualine.nvim', config = require('plugins.lualine') })
        use({ 'is0n/fm-nvim' })

        -- Theme
        use({ 'tjdevries/colorbuddy.nvim' })
        use({
            'norcalli/nvim-colorizer.lua',
            config = function()
                require('colorizer').setup({})
            end,
        })
        use({ 'marko-cerovac/material.nvim' })
        use({ 'folke/tokyonight.nvim' })

        -- Other
        use({ 'voldikss/vim-floaterm' })
        use({ 'karb94/neoscroll.nvim' })
        use({ 'ojroques/vim-oscyank' })
        use({ 'phaazon/hop.nvim', branch = 'v1', config = require('plugins.hop') })
        use({
            'terrortylor/nvim-comment',
            config = function()
                require('nvim_comment').setup()
            end,
        })
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
