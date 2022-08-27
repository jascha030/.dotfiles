local packer = nil

function init()
	if not packer then
		vim.cmd([[packadd packer.nvim]])
		packer = require("packer")
	end

	packer.init({
		disable_commands = true,
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "single" })
			end,
		},
		profile = {
			enable = true,
			threshold = 1,
		},
	})

    local use = packer.use
    packer.reset()
    
	use({ "wbthomason/packer.nvim", opt = true })


    use({
        'ojroques/vim-oscyank',
        'voldikss/vim-floaterm',
        { 
            'phaazon/hop.nvim', 
            branch = 'v2', 
            config = function()
                require('hop').setup({
                    keys = 'etovxqpdygfblzhckisuran',
                    jump_on_sole_occurrence = false,
                })
            end 
        },
        { 'terrortylor/nvim-comment', config = [[require('nvim_comment').setup()]] },
        { 
            'goolord/alpha-nvim', config = function()
                require('alpha').setup(require('alpha.themes.startify').opts)
            end
        },
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

	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
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
	})

    use({ 'mfussenegger/nvim-dap' })

	use({
		"kyazdani42/nvim-web-devicons",
		{ "yamatsum/nvim-nonicons", branch = "feat/lua" },
		{
			"kyazdani42/nvim-tree.lua",
			requires = { "kyazdani42/nvim-web-devicons" },
			config = require("plugins.tree"),
		},
		{ "petertriho/nvim-scrollbar", config = [[require("scrollbar").setup({})]] },
		{ "hoob3rt/lualine.nvim", config = require("plugins.lualine") },
        { 'j-hui/fidget.nvim', config = require('fidget').setup({
        text = { spinner = 'dots' },
        window = { relative = 'editor', blend = 0, zindex = nil },
    })},
	})

	use({ "wakatime/vim-wakatime" })
end

local plugins = setmetatable({}, {
	__index = function(_, key)
		init()
		return packer[key]
	end,
})

return plugins
