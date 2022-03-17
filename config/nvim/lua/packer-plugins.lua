return require("packer").startup(function(use)
	use({ "wbthomason/packer.nvim" })
	use({ "lewis6991/impatient.nvim", config = [[require('impatient')]] })
	use({
		"neovim/nvim-lspconfig",
		"williamboman/nvim-lsp-installer",
	})
	use({ "marko-cerovac/material.nvim" })
	use({ "nvim-treesitter/nvim-treesitter", irun = ":TSUpdate" })
	use({ "nvim-treesitter/playground" })
	use({ "onsails/lspkind-nvim" })
	use({ "phaazon/hop.nvim", branch = "v1" })
	use({
		"hoob3rt/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})
	use({
		"goolord/alpha-nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("alpha").setup(require("alpha.themes.startify").opts)
		end,
	})
	use({ "kyazdani42/nvim-tree.lua" })
	use({ "norcalli/nvim-colorizer.lua" })
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
		},
	})
	use({ "nvim-telescope/telescope-file-browser.nvim" })
	use({ "nvim-telescope/telescope-fzy-native.nvim" })
	-- cmp
	use({ "hrsh7th/nvim-cmp" })
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-path" })
	use({ "hrsh7th/cmp-buffer" })
	use({ "hrsh7th/cmp-vsnip" })
	use({ "L3MON4D3/LuaSnip" })
	use({ "saadparwaiz1/cmp_luasnip" })
	use({ "tjdevries/colorbuddy.nvim" })
	use({ "simrat39/rust-tools.nvim" })
	use({ "mfussenegger/nvim-dap" })
	use({ "karb94/neoscroll.nvim" })
	use({ "iamcco/markdown-preview.nvim" })
	use({ "ojroques/vim-oscyank" })
	use({ "folke/tokyonight.nvim" })
	use({ "ncm2/ncm2" })
	use({ "wakatime/vim-wakatime" })
	use({ "voldikss/vim-floaterm" })
	use({ "petertriho/nvim-scrollbar" })
	-- use { 'terryma/vim-multiple-cursors' }
	use({ "p00f/nvim-ts-rainbow" })
	use({ "nvim-treesitter/nvim-treesitter-textobjects" })
	use({
		"noib3/nvim-cokeline",
		requires = "kyazdani42/nvim-web-devicons",
	})
	use({ "norcalli/nvim-colorizer.lua" })
	use({ "jose-elias-alvarez/null-ls.nvim" })
end)
