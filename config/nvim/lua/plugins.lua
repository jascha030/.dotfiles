local packer = nil

require('utils').plugin.packer_init()

vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
]])

local function init()
    if not packer then
        vim.cmd([[packadd packer.nvim]])
        packer = require('packer')
    end

    packer.init({
        max_jobs = 5,
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
    use({
        'yamatsum/nvim-nonicons',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = function()
            require('nvim-web-devicons').setup({
                default_icon = require('utils').conf.devicons.default_icon,
            })
        end,
    })
    use({

        { 'kyazdani42/nvim-tree.lua', config = require('plugins.tree') },
        'ojroques/vim-oscyank',
        { 'voldikss/vim-floaterm' },
        {
            'phaazon/hop.nvim',
            branch = 'v2',
            config = function()
                require('hop').setup({
                    keys = 'etovxqpdygfblzhckisuran',
                    jump_on_sole_occurrence = false,
                })
            end,
        },
        { 'terrortylor/nvim-comment', config = [[require('nvim_comment').setup()]] },
        { 'petertriho/nvim-scrollbar', config = [[require("scrollbar").setup({})]] },
        {
            'goolord/alpha-nvim',
            config = function()
                require('alpha').setup(require('alpha.themes.startify').opts)
            end,
        },
        { 'noib3/nvim-cokeline', config = require('plugins.coke') },
        { 'hoob3rt/lualine.nvim', config = require('plugins.line') },
        { 'folke/which-key.nvim', config = [[require('which-key').setup({})]] },
        { 'ziontee113/color-picker.nvim', config = [[require('color-picker').setup({})]] },
        { 'norcalli/nvim-colorizer.lua', config = [[require('colorizer').setup()]] },
        { 'windwp/nvim-autopairs', config = [[require('nvim-autopairs').setup({})]] },
    })

    -- Treesitter
    use({
        { 'nvim-treesitter/nvim-treesitter', irun = ':TSUpdate', config = require('plugins.treesitter') },
        { 'nvim-treesitter/nvim-treesitter-textobjects' },
        { 'nvim-treesitter/playground' },
        { 'p00f/nvim-ts-rainbow' },
    })

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

    use({
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig',
        { 'onsails/lspkind-nvim' },
        { 'jose-elias-alvarez/null-ls.nvim' },
        { 'hrsh7th/nvim-cmp', config = require('plugins.nvim-cmp') },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-vsnip' },
        { 'L3MON4D3/LuaSnip' },
        { 'saadparwaiz1/cmp_luasnip' },
        { 'ncm2/ncm2' },
        { 'simrat39/rust-tools.nvim' },
        { 'mfussenegger/nvim-dap' },
        { 'theHamsta/nvim-dap-virtual-text', config = [[require('nvim-dap-virtual-text').setup()]] },
        {
            'saecki/crates.nvim',
            event = { 'BufRead Cargo.toml' },
            requires = { { 'nvim-lua/plenary.nvim' } },
            config = [[require('crates').setup()]],
        },
        { 'folke/trouble.nvim' },
        {
            'j-hui/fidget.nvim',
            config = function()
                require('fidget').setup({
                    text = { spinner = 'dots' },
                    window = { relative = 'editor', blend = 0, zindex = nil },
                })
            end,
        },
    })

    use('b0o/schemastore.nvim')
    use({ 'wakatime/vim-wakatime' })

    -- only included for the EmmyLua annotations.
    use({ 'folke/lua-dev.nvim', opt = true })
    use({ os.getenv('HOME') .. '/.development/Projects/lua/nitepal.nvim' })
end

local plugins = setmetatable({}, {
    __index = function(_, key)
        init()
        return packer[key]
    end,
})

return plugins
