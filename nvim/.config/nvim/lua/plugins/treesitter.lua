require'nvim-treesitter.configs'.setup {
  	ensure_installed = {
		"typescript", 
		"javascript", 
		"python",
		"php",
		"bash",
		"lua",
	},
	indent = {
    	enable = true,
  	},
  	highlight = {
    	enable = true,
  	}
}

