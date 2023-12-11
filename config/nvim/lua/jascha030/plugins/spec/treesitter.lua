local M = {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPost', 'BufNewFile' },
    -- event = 'VeryLazy',
    dependencies = {
        { 'nvim-treesitter/nvim-treesitter-context', config = true },
        { 'p00f/nvim-ts-rainbow', lazy = true },
        { 'theHamsta/nvim-treesitter-commonlisp' },
        { 'nvim-treesitter/playground', cmd = 'TSPlaygroundToggle' },
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
    opts = {
        ensure_installed = {
            'bash',
            'comment',
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
            'ocaml',
            'ocaml_interface',
            'php',
            'phpdoc',
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
        playground = {
            enable = true,
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
            additional_vim_regex_highlighting = false,
            disable = { 'zsh' },
        },
        rainbow = {
            enable = false,
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

function M.build()
    require('nvim-treesitter.install').update({ with_sync = true })
end

function M.config(_, opts)
    local parsers = require('nvim-treesitter.parsers')
    local parser_config = parsers.get_parser_configs()

    parser_config.blade = {
        install_info = {
            url = 'https://github.com/EmranMR/tree-sitter-blade',
            files = { 'src/parser.c' },
            branch = 'main',
        },
        filetype = 'blade',
    }

    vim.filetype.add({
        pattern = {
            ['.*%.blade%.php'] = 'blade',
        },
    })
    --
    -- vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    --     group = vim.api.nvim_create_augroup('BladeFiltypeRelated', { clear = true }),
    --     pattern = '*.blade.php',
    --     callback = function()
    --         vim.bo.filetype = 'blade'
    --     end,
    -- })
    --
    require('nvim-treesitter.configs').setup(opts)

    local ft_to_lang = parsers.ft_to_lang
    parsers.ft_to_lang = function(ft)
        -- if ft == 'zsh' then
        --     return 'bash'
        -- end

        -- if ft == 'xml' then
        -- return 'html'
        -- end

        return ft_to_lang(ft)
    end
end

return M
