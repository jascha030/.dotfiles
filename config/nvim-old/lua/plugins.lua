local packer = nil

local function init()
    if not packer then
        vim.cmd([[packadd packer.nvim]])
        packer = require('packer')
    end

    packer.init({
        compile_path = require('utils').data_dir() .. 'lua/_compiled.lua',
        disable_commands = true,
        display = {
            open_fn = function()
                return require('packer.util').float({ border = 'single' })
            end,
        },
        profile = {
            enable = true,
            threshold = 1,
        },
    })

    local use = packer.use

    packer.reset()

    use({ 'wbthomason/packer.nvim', opt = true })
    --use({ 'lewis6991/impatient.nvim', config = [[require('impatient')]] })
    -- use({ 'kyazdani42/nvim-web-devicons', config = require('plugins.devicons') })

    use('kyazdani42/nvim-web-devicons')
    use({ 'yamatsum/nvim-nonicons', branch = 'feat/lua' })
    use({
        'folke/tokyonight.nvim',
        requires = { 'marko-cerovac/material.nvim' },
    })
    -- use({
    -- 'yamatsum/nvim-nonicons',
    -- requires = 'kyazdani42/nvim-web-devicons',
    -- after = 'tokyonight.nvim',
    -- config = require('plugins.devicons'),
    -- })
    use({
        'j-hui/fidget.nvim',
        config = require('plugins.fidget-nvim'),
    })
    use({
        'goolord/alpha-nvim',
        config = require('plugins.alpha-nvim'),
    })

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
    use({ 'ncm2/ncm2' })
    use({ 'simrat39/rust-tools.nvim' })
    use({ 'mfussenegger/nvim-dap' })
    use({
        'theHamsta/nvim-dap-virtual-text',
        config = function()
            require('nvim-dap-virtual-text').setup()
        end,
    })
    use({
        'saecki/crates.nvim',
        event = { 'BufRead Cargo.toml' },
        requires = { { 'nvim-lua/plenary.nvim' } },
        config = [[require('crates').setup()]],
    })
    use({
        'folke/trouble.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
        config = require('plugins.trouble'),
    })
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
    use({
        'nvim-treesitter/nvim-treesitter',
        irun = ':TSUpdate',
        config = require('plugins.treesitter'),
    })
    -- Ui/Utils
    use({ 'kyazdani42/nvim-tree.lua', config = require('plugins.tree') })
    use({ 'petertriho/nvim-scrollbar', config = require('plugins.nvim-scrollbar') })
    use({ 'noib3/nvim-cokeline', config = require('plugins.cokeline') })
    use({ 'hoob3rt/lualine.nvim', config = require('plugins.lualine') })
    use({ 'is0n/fm-nvim' })
    use({ 'ziontee113/color-picker.nvim', config = require('plugins.colorpicker') })
    use({ 'filipdutescu/renamer.nvim', branch = 'master', requires = { { 'nvim-lua/plenary.nvim' } } })
    use({ 'folke/which-key.nvim', config = [[require('which-key').setup({})]] })
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

    -- Other
    use({ 'terrortylor/nvim-comment', config = [[require('nvim_comment').setup()]] })
    use({ 'ii14/neorepl.nvim' })
    use({ 'voldikss/vim-floaterm' })
    use({ 'karb94/neoscroll.nvim' })
    use({ 'ojroques/vim-oscyank' })
    use({
        'phaazon/hop.nvim',
        branch = 'v1',
        config = require('plugins.hop'),
    })
    use({ 'wakatime/vim-wakatime' })
end

local plugins = setmetatable({}, {
    __index = function(_, key)
        init()
        return packer[key]
    end,
})

return plugins
