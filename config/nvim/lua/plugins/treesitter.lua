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
                    additional_vim_regex_highlighting = { 'zsh' },
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
            })

            parsers.ft_to_lang = function(ft)
                if ft == 'zsh' then
                    return 'bash'
                end

                if ft == 'xml' then
                    return 'html'
                end

                return ft_to_lang(ft)
            end
        end,
    },
    {
        'm-demare/hlargs.nvim',
        opts = {
            color = '#ea1479',
            highlight = {},
            excluded_filetypes = {},
            paint_arg_declarations = true,
            paint_arg_usages = true,
            paint_catch_blocks = {
                declarations = false,
                usages = false,
            },
            extras = {
                named_parameters = false,
            },
            hl_priority = 10000,
            excluded_argnames = {
                declarations = {},
                usages = {
                    python = { 'self', 'cls' },
                    lua = { 'self' },
                },
            },
            performance = {
                parse_delay = 1,
                slow_parse_delay = 50,
                max_iterations = 400,
                max_concurrent_partial_parses = 30,
                debounce = {
                    partial_parse = 3,
                    partial_insert_mode = 100,
                    total_parse = 700,
                    slow_parse = 5000,
                },
            },
        },
    },
}
