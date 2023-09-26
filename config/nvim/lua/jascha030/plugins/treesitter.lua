local M = {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
        'nvim-treesitter/nvim-treesitter-context',
        'nvim-treesitter/playground',
        'p00f/nvim-ts-rainbow',
        'theHamsta/nvim-treesitter-commonlisp',
    },
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
        ensure_installed = {
            'bash',
            'comment',
            'css',
            'gitattributes',
            'git_config',
            'gitignore',
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
            'vimdoc',
            'swift',
        },
        query_linter = {
            enable = true,
            use_virtual_text = true,
            lint_events = { 'BufWrite', 'CursorHold' },
        },
        indent = { enable = true },
        highlight = {
            enable = true,
            use_languagetree = true,
        },
        rainbow = {
            enable = true,
            extended_mode = true,
            max_file_lines = 1000,
        },
        playground = {},
        textobjects = {
            ['aa'] = '@parameters.outer',
            ['ia'] = '@parameters.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = '@class.outer',
            },
            goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer',
            },
            goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer',
            },
            goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer',
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
                ['<leader>A'] = '@parameter.inner',
            },
        },
    },
}

function M.config(_, opts)
    local parsers = require('nvim-treesitter.parsers')
    local ft_to_lang = parsers.ft_to_lang

    require('nvim-treesitter.configs').setup(opts)

    parsers.ft_to_lang = function(ft)
        if ft == 'zsh' then
            return 'bash'
        end

        if ft == 'xml' then
            return 'html'
        end

        return ft_to_lang(ft)
    end
end

return M
