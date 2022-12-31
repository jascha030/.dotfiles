return {
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            'nvim-treesitter/nvim-treesitter-context',
            'nvim-treesitter/playground',
            'p00f/nvim-ts-rainbow',
            'theHamsta/nvim-treesitter-commonlisp',
        },
        build = ':TSUpdate',
        config = function()
            local parsers = require('nvim-treesitter.parsers')
            local ft_to_lang = parsers.ft_to_lang

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
                highlight = { enable = true, additional_vim_regex_highlighting = { 'zsh' } },
                rainbow = { enable = true, extended_mode = true, max_file_lines = 1000 },
                playground = {},
            })

            parsers.ft_to_lang = function(ft)
                return ft == 'zsh' and 'bash' or ft_to_lang(ft)
            end
        end,
    },
}
