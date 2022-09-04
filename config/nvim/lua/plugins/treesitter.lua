return function()
    local parsers = require('nvim-treesitter.parsers')

    require('nvim-treesitter.configs').setup({
        ensure_installed = {
            'bash',
            'comment',
            'css',
            'javascript',
            'json',
            'json5',
            'lua',
            'php',
            'python',
            'markdown',
            'markdown_inline',
            'toml',
            'typescript',
            'vim',
            'yaml',
        },
        indent = { enable = true },
        highlight = {
            enable = true,
            disable = {
				"zsh"
			},
        },
        rainbow = {
            enable = true,
            extended_mode = true,
            max_file_lines = nil,
        },
    })

    -- https://github.com/nvim-treesitter/nvim-treesitter/issues/655#issuecomment-1021160477
    -- local ft_to_lang = parsers.ft_to_lang

    -- parsers.ft_to_lang = function(ft)
        -- return ft == 'zsh' and 'bash' or ft_to_lang(ft)
    -- end
end
