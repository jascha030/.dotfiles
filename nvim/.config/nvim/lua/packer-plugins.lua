return require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use {
		'neovim/nvim-lspconfig',
        'williamboman/nvim-lsp-installer',
	}
	use 'marko-cerovac/material.nvim'
	use { 'nvim-treesitter/nvim-treesitter', irun = ':TSUpdate' }
	use 'nvim-treesitter/playground'
	use 'onsails/lspkind-nvim'
	use {
		'hoob3rt/lualine.nvim',
  		requires = {'kyazdani42/nvim-web-devicons', opt = true}
	}
	use 'kyazdani42/nvim-tree.lua'
    use 'norcalli/nvim-colorizer.lua'
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            {'nvim-lua/popup.nvim'},
            {'nvim-lua/plenary.nvim'}
        }
    }
    use 'hrsh7th/nvim-compe'
    use 'tjdevries/colorbuddy.nvim'
    use 'karb94/neoscroll.nvim'
    use 'iamcco/markdown-preview.nvim'
    use 'ojroques/vim-oscyank'
    use 'folke/tokyonight.nvim'
    use 'ncm2/ncm2'
	use 'wakatime/vim-wakatime'
end)
