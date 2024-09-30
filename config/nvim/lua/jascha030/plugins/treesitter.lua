---@type LazyPluginSpec
local M = {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
        {
            'nvim-treesitter/nvim-treesitter-textobjects',
            event = 'VeryLazy',
        },
        {
            'nvim-treesitter/nvim-treesitter-context',
            config = true,
        },
        {
            'p00f/nvim-ts-rainbow',
            lazy = true,
        },
        {
            'theHamsta/nvim-treesitter-commonlisp',
            ft = 'query',
        },
        {
            'nvim-treesitter/playground',
            cmd = 'TSPlaygroundToggle',
        },
        {
            'bleksak/treesitter-neon',
            lazy = true,
        },
        {
            'MTDL9/vim-log-highlighting',
            ft = 'log',
        },
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
            'blade',
        },
        playground = {
            enable = true,
        },
        query_linter = {
            enable = true,
            use_virtual_text = true,
        },
        indent = {
            enable = true,
        },
        highlight = {
            enable = true,
            use_languagetree = true,
            additional_vim_regex_highlighting = { 'zsh' },
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

function M.config(_, opts)
    local parsers = require('nvim-treesitter.parsers')
    require('nvim-treesitter.configs').setup(opts)

    local parser_config = parsers.get_parser_configs()

    vim.filetype.add({
        pattern = {
            ['.*%.blade%.php'] = 'blade',
        },
    })

    ---@diagnostic disable-next-line: inject-field
    parser_config.blade = {
        install_info = {
            url = 'https://github.com/EmranMR/tree-sitter-blade',
            files = { 'src/parser.c' },
            branch = 'main',
        },
        filetype = 'blade',
    }

    ---@diagnostic disable-next-line: inject-field
    parser_config.neon = {
        install_info = {
            url = vim.fn.expand('$HOME/.local/share/nvim/lazy/treesitter-neon'),
            generate_requires_npm = false,
            requires_generate_from_grammar = false,
            files = { 'src/parser.c', 'src/scanner.c' },
        },
        filetype = 'neon',
    }

    -- local ft_to_lang = parsers.ft_to_lang
    -- parsers.ft_to_lang = function(ft)
    --     return ft_to_lang(ft)
    -- end
end

return M
