local uis = vim.api.nvim_list_uis()
local has_uis = #uis > 0

---@type table<string, string>
local FT_TO_LANG_ALIASES = { dotenv = 'bash' }

---@type string[]
local HIGHLIGHTING_DISABLED = { 'zsh' }

---@type string[]
local HIGHLIGHTING_ADD_VIM_REGEX = { 'zsh' }

---@type LazyPluginSpec
--- Check Runtime files :echo nvim_get_runtime_file('parser', v:true)
---@diagnostic disable-next-line: unused-local
local M = {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile', 'FileType' },
    cond = has_uis,
    dependencies = {
        { 'nvim-treesitter/nvim-treesitter-textobjects', event = 'VeryLazy' },
        { 'nvim-treesitter/nvim-treesitter-context', config = true },
        { 'theHamsta/nvim-treesitter-commonlisp', ft = 'query' },
        { 'bleksak/treesitter-neon', ft = 'neon' },
        { 'MTDL9/vim-log-highlighting', ft = 'log' },
        { 'folke/ts-comments.nvim', opts = {}, event = 'VeryLazy' },
    },
    ---@module 'nvim-treesitter.configs'
    opts = {
        auto_install = has_uis,
        sync_install = true,
        ensure_installed = {
            'bash',
            'blade',
            'comment',
            'commonlisp',
            'css',
            'git_config',
            'git_rebase',
            'gitattributes',
            'gitcommit',
            'gitignore',
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
            'html',
            'xml',
            'scss',
            'toml',
            'typescript',
            'vim',
            'vimdoc',
            'yaml',
        },
        query_linter = {
            enable = true,
            use_virtual_text = true,
        },
        indent = { enable = true },
        highlight = {
            enable = true,
            disable = function(lang, buf)
                return (
                    require('jascha030.utils.buffer').is_huge({ bufnr = buf })
                    or vim.tbl_contains(HIGHLIGHTING_DISABLED, lang)
                )
            end,
            use_languagetree = true,
            additional_vim_regex_highlighting = HIGHLIGHTING_ADD_VIM_REGEX,
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
    local ts_query = require('vim.treesitter.query')

    local info_string_aliases = {
        ex = 'elixir',
        pl = 'perl',
        sh = 'bash',
        ts = 'typescript',
        uxn = 'uxntal',
    }

    require('nvim-treesitter.configs').setup(opts)

    ts_query.add_directive('set-lang-from-info-string!', function(match, _, bufnr, pred, metadata)
        local node = match[pred[2]]
        if not node then
            return
        end

        local ok, text = pcall(vim.treesitter.get_node_text, node, bufnr)
        if not ok or text == '' then
            return
        end

        local injection_alias = text:lower()
        local filetype = vim.filetype.match({ filename = 'a.' .. injection_alias })
        metadata['injection.language'] = filetype or info_string_aliases[injection_alias] or injection_alias
    end, { force = true, all = false })

    local parser_config = parsers.get_parser_configs()

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

    for ft, parser in pairs(FT_TO_LANG_ALIASES) do
        vim.treesitter.language.register(parser, ft)
    end
end

---@module 'lazy.types'
---@type LazyPluginSpec[]
return {
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        build = ':TSUpdate',
        config = function()
            local ts = require('nvim-treesitter')

            local parsers = {
                'bash',
                'blade',
                'comment',
                'commonlisp',
                'css',
                'git_config',
                'git_rebase',
                'gitattributes',
                'gitcommit',
                'gitignore',
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
                'html',
                'xml',
                'scss',
                'toml',
                'typescript',
                'vim',
                'vimdoc',
                'yaml',
            }

            for _, parser in ipairs(parsers) do
                ts.install(parser)
            end

            local parsers_config = require('nvim-treesitter.parsers').get_parser_configs()

            ---@diagnostic disable-next-line: inject-field
            parsers_config.blade = {
                install_info = {
                    url = 'https://github.com/EmranMR/tree-sitter-blade',
                    files = { 'src/parser.c' },
                    branch = 'main',
                },
                filetype = 'blade',
            }

            ---@diagnostic disable-next-line: inject-field
            parsers_config.neon = {
                install_info = {
                    url = vim.fn.expand('$HOME/.local/share/nvim/lazy/treesitter-neon'),
                    generate_requires_npm = false,
                    requires_generate_from_grammar = false,
                    files = { 'src/parser.c', 'src/scanner.c' },
                },
                filetype = 'neon',
            }

            local FT_TO_LANG_ALIASES = { dotenv = 'bash' }
            for ft, parser in pairs(FT_TO_LANG_ALIASES) do
                vim.treesitter.language.register(parser, ft)
            end

            -- Get all filetypes that have treesitter support for the FileType autocommand
            local patterns = {}
            for _, parser in ipairs(parsers) do
                local parser_patterns = vim.treesitter.language.get_filetypes(parser)
                for _, pp in pairs(parser_patterns) do
                    table.insert(patterns, pp)
                end
            end

            -- Add custom parsers to patterns
            table.insert(patterns, 'blade')
            table.insert(patterns, 'neon')
            table.insert(patterns, 'log')

            -- Enable treesitter features for supported filetypes
            vim.api.nvim_create_autocmd('FileType', {
                pattern = patterns,
                callback = function()
                    -- Syntax highlighting (Neovim native)
                    vim.treesitter.start()

                    -- Folding (Neovim native)
                    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                    vim.wo.foldmethod = 'expr'

                    -- Indentation (nvim-treesitter)
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })

            -- Custom directive for code fence language injection in markdown
            local ts_query = require('vim.treesitter.query')
            local info_string_aliases = {
                ex = 'elixir',
                pl = 'perl',
                sh = 'bash',
                ts = 'typescript',
                uxn = 'uxntal',
            }

            ts_query.add_directive('set-lang-from-info-string!', function(match, _, bufnr, pred, metadata)
                local node = match[pred[2]]
                if not node then
                    return
                end

                local ok, text = pcall(vim.treesitter.get_node_text, node, bufnr)
                if not ok or text == '' then
                    return
                end

                local injection_alias = text:lower()
                local filetype = vim.filetype.match({ filename = 'a.' .. injection_alias })
                metadata['injection.language'] = filetype or info_string_aliases[injection_alias] or injection_alias
            end, { force = true, all = false })
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        branch = 'main',
        dependencies = { 'nvim-treesitter/nvim-treesitter', branch = 'main' },
        init = function()
            -- Disable entire built-in ftplugin mappings to avoid conflicts
            vim.g.no_plugin_maps = true
        end,
        keys = function()
            local select = require('nvim-treesitter-textobjects.select')
            local move = require('nvim-treesitter-textobjects.move')
            local swap = require('nvim-treesitter-textobjects.swap')
            local ts_repeat_move = require('nvim-treesitter-textobjects.repeatable_move')

            return {
                -- SELECT KEYMAPS (Visual and Operator-pending modes)
                {
                    'aa',
                    function()
                        select.select_textobject('@parameter.outer', 'textobjects')
                    end,
                    mode = { 'x', 'o' },
                    desc = 'Select outer parameter/argument',
                },
                {
                    'ia',
                    function()
                        select.select_textobject('@parameter.inner', 'textobjects')
                    end,
                    mode = { 'x', 'o' },
                    desc = 'Select inner parameter/argument',
                },
                {
                    'af',
                    function()
                        select.select_textobject('@function.outer', 'textobjects')
                    end,
                    mode = { 'x', 'o' },
                    desc = 'Select outer function',
                },
                {
                    'if',
                    function()
                        select.select_textobject('@function.inner', 'textobjects')
                    end,
                    mode = { 'x', 'o' },
                    desc = 'Select inner function',
                },
                {
                    'ac',
                    function()
                        select.select_textobject('@class.outer', 'textobjects')
                    end,
                    mode = { 'x', 'o' },
                    desc = 'Select outer class',
                },
                {
                    'ic',
                    function()
                        select.select_textobject('@class.inner', 'textobjects')
                    end,
                    mode = { 'x', 'o' },
                    desc = 'Select inner class',
                },
                {
                    'as',
                    function()
                        select.select_textobject('@local.scope', 'locals')
                    end,
                    mode = { 'x', 'o' },
                    desc = 'Select local scope',
                },
                -- SWAP KEYMAPS (Normal mode)
                {
                    '<leader>a',
                    function()
                        swap.swap_next('@parameter.inner')
                    end,
                    mode = 'n',
                    desc = 'Swap parameter with next',
                },
                {
                    '<leader>A',
                    function()
                        swap.swap_previous('@parameter.outer')
                    end,
                    mode = 'n',
                    desc = 'Swap parameter with previous',
                },
                -- MOVE KEYMAPS (Normal, Visual, Operator-pending modes)
                {
                    ']m',
                    function()
                        move.goto_next_start('@function.outer', 'textobjects')
                    end,
                    mode = { 'n', 'x', 'o' },
                    desc = 'Go to next function start',
                },
                {
                    ']]',
                    function()
                        move.goto_next_start('@class.outer', 'textobjects')
                    end,
                    mode = { 'n', 'x', 'o' },
                    desc = 'Go to next class start',
                },
                {
                    ']M',
                    function()
                        move.goto_next_end('@function.outer', 'textobjects')
                    end,
                    mode = { 'n', 'x', 'o' },
                    desc = 'Go to next function end',
                },
                {
                    '][',
                    function()
                        move.goto_next_end('@class.outer', 'textobjects')
                    end,
                    mode = { 'n', 'x', 'o' },
                    desc = 'Go to next class end',
                },
                {
                    '[m',
                    function()
                        move.goto_previous_start('@function.outer', 'textobjects')
                    end,
                    mode = { 'n', 'x', 'o' },
                    desc = 'Go to previous function start',
                },
                {
                    '[[',
                    function()
                        move.goto_previous_start('@class.outer', 'textobjects')
                    end,
                    mode = { 'n', 'x', 'o' },
                    desc = 'Go to previous class start',
                },
                {
                    '[M',
                    function()
                        move.goto_previous_end('@function.outer', 'textobjects')
                    end,
                    mode = { 'n', 'x', 'o' },
                    desc = 'Go to previous function end',
                },
                {
                    '[]',
                    function()
                        move.goto_previous_end('@class.outer', 'textobjects')
                    end,
                    mode = { 'n', 'x', 'o' },
                    desc = 'Go to previous class end',
                },
                -- REPEATABLE MOVE KEYMAPS (with ; and ,)
                {
                    ';',
                    function()
                        ts_repeat_move.repeat_last_move_next()
                    end,
                    mode = { 'n', 'x', 'o' },
                    desc = 'Repeat last move forward',
                },
                {
                    ',',
                    function()
                        ts_repeat_move.repeat_last_move_previous()
                    end,
                    mode = { 'n', 'x', 'o' },
                    desc = 'Repeat last move backward',
                },
                {
                    'f',
                    function()
                        return ts_repeat_move.builtin_f_expr()
                    end,
                    mode = { 'n', 'x', 'o' },
                    expr = true,
                    desc = 'Find forward',
                },
                {
                    'F',
                    function()
                        return ts_repeat_move.builtin_F_expr()
                    end,
                    mode = { 'n', 'x', 'o' },
                    expr = true,
                    desc = 'Find backward',
                },
                {
                    't',
                    function()
                        return ts_repeat_move.builtin_t_expr()
                    end,
                    mode = { 'n', 'x', 'o' },
                    expr = true,
                    desc = 'Till forward',
                },
                {
                    'T',
                    function()
                        return ts_repeat_move.builtin_T_expr()
                    end,
                    mode = { 'n', 'x', 'o' },
                    expr = true,
                    desc = 'Till backward',
                },
            }
        end,
        opts = {
            select = {
                enable = true,
                lookahead = true,
                selection_modes = {
                    ['@parameter.outer'] = 'v',
                    ['@function.outer'] = 'V',
                    ['@class.outer'] = '<c-v>',
                },
                include_surrounding_whitespace = false,
            },
            move = { enable = true, set_jumps = true },
            swap = { enable = true },
        },
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        branch = 'main',
        dependencies = { 'nvim-treesitter/nvim-treesitter', branch = 'main' },
        config = true,
    },
    {
        'folke/ts-comments.nvim',
        event = 'VeryLazy',
        config = true,
    },
}
