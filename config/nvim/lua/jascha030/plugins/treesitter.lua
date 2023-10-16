local M = {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        { 'p00f/nvim-ts-rainbow' },
        { 'theHamsta/nvim-treesitter-commonlisp' },
    },
    build = ':TSUpdate',
    event = {
        'VeryLazy',
        -- 'BufNewFile', 'BufReadPost',
    },
    opts = {
        ensure_installed = {
            'bash',
            -- 'comment',
            'commonlisp',
            'css',
            'gitattributes',
            'git_config',
            'gitignore',
            'gitcommit',
            'javascript',
            'json',
            'json5',
            'jsonc',
            'lua',
            'markdown',
            'markdown_inline',
            'php',
            'python',
            'query',
            'regex',
            'swift',
            'toml',
            'typescript',
            'vim',
            'vimdoc',
            'yaml',
        },
        query_linter = {
            enable = true,
            use_virtual_text = true,
            lint_events = {
                'BufWrite',
                'CursorHold',
            },
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
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = '<cr>',
                node_incremental = '<cr>',
                scope_incremental = false,
                node_decremental = '<bs>',
            },
        },
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

