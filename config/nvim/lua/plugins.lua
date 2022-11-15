require('utils').assert_packer()

local packer = nil

vim.cmd([[packadd packer.nvim]])
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
        'lewis6991/impatient.nvim',
        'kyazdani42/nvim-web-devicons',
        'yamatsum/nvim-nonicons',
        'nvim-lua/plenary.nvim',
        'noib3/nvim-cokeline',
        'voldikss/vim-floaterm',
        'ojroques/vim-oscyank',
        'hoob3rt/lualine.nvim',
        'kyazdani42/nvim-tree.lua',
        'sheerun/vim-polyglot',
        {
            'lukas-reineke/indent-blankline.nvim',
            config = function()
                require('indent_blankline').setup({
                    filetype_exclude = { 'dashboard' },
                })
            end,
        },
        'f-person/git-blame.nvim',
        'wakatime/vim-wakatime',
        { 'akinsho/toggleterm.nvim', tag = '*' },
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
        'goolord/alpha-nvim',
        'ziontee113/icon-picker.nvim',
        'gelguy/wilder.nvim',
        'yamatsum/nvim-cursorline',
        { 'luukvbaal/stabilize.nvim', config = [[require("stabilize").setup()]] },
        { 'terrortylor/nvim-comment', config = [[require('nvim_comment').setup()]] },
        { 'petertriho/nvim-scrollbar', config = [[require("scrollbar").setup({})]] },
        { 'folke/which-key.nvim', config = [[require('which-key').setup({})]] },
        { 'ziontee113/color-picker.nvim', config = [[require('color-picker').setup({})]] },
        { 'norcalli/nvim-colorizer.lua', config = [[require('colorizer').setup()]] },
        { 'windwp/nvim-autopairs', config = [[require('nvim-autopairs').setup({})]] },
        {
            'zbirenbaum/neodim',
            event = 'LspAttach',
            config = function()
                require('neodim').setup({
                    alpha = 0.75,
                    blend_color = '#000000',
                    update_in_insert = { enable = true, delay = 100 },
                    hide = { virtual_text = true, signs = true, underline = true },
                })
            end,
        },
    })

    use({ os.getenv('HOME') .. '/.development/Projects/Lua/nitepal.nvim' })
    -- Treesitter
    use({
        { 'nvim-treesitter/nvim-treesitter', irun = ':TSUpdate' },
        'nvim-treesitter/nvim-treesitter-textobjects',
        'nvim-treesitter/nvim-treesitter-context',
        'nvim-treesitter/playground',
        'p00f/nvim-ts-rainbow',
    }, { 'theHamsta/nvim-treesitter-commonlisp', after = 'nvim-treesitter' })

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
        'ray-x/lsp_signature.nvim',
        'onsails/lspkind-nvim',
        'jose-elias-alvarez/null-ls.nvim',
        { 'hrsh7th/nvim-cmp', config = [[require('lsp.cmp')]] },
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-vsnip',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        'ncm2/ncm2',
        'simrat39/rust-tools.nvim',
        'b0o/schemastore.nvim',
        'folke/trouble.nvim',
        {
            'saecki/crates.nvim',
            event = { 'BufRead Cargo.toml' },
            requires = { { 'nvim-lua/plenary.nvim' } },
            config = [[require('crates').setup()]],
        },
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

    use({
        'mfussenegger/nvim-dap',
        'rcarriga/nvim-dap-ui',
        'theHamsta/nvim-dap-virtual-text',
        'nvim-telescope/telescope-dap.nvim',
    })

    -- only included for the EmmyLua annotations.
    use({ 'folke/lua-dev.nvim', opt = true })
end

local plugins = setmetatable({}, {
    __index = function(_, key)
        init()
        return packer[key]
    end,
})

return plugins
