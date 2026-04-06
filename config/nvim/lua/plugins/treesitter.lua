local uis = vim.api.nvim_list_uis()
local has_uis = #uis > 0

---@type table<string, string>
local FT_TO_LANG_ALIASES = { dotenv = 'bash' }

---@module 'lazy.types'
---@type LazyPluginSpec[]
return {
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        build = ':TSUpdate',
        cond = has_uis,
        opts = {
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
                'svelte',
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
        },
        config = function(_, opts)
            local ts = require('nvim-treesitter')
            local parsers = opts.ensure_installed or {}

            ts.install(parsers)

            -- for _, parser in ipairs(parsers) do
            --     ts.install(parser)
            -- end

            for ft, parser in pairs(FT_TO_LANG_ALIASES) do
                vim.treesitter.language.register(parser, ft)
            end

            -- Get all filetypes that have treesitter support for the FileType autocommand
            -- local patterns = {}
            -- for _, parser in ipairs(parsers) do
            --     local parser_patterns = vim.treesitter.language.get_filetypes(parser)
            --
            --     for _, pp in pairs(parser_patterns) do
            --         table.insert(patterns, pp)
            --     end
            -- end

            ---@todo: handle other parsers and FileType autocmd
            --
            -- -- Enable treesitter features for supported filetypes
            -- ---@todo: move to autocmds.lua
            -- vim.api.nvim_create_autocmd('FileType', {
            --     pattern = patterns,
            --     callback = function()
            --         vim.treesitter.start()
            --         vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            --         vim.wo.foldmethod = 'expr'
            --         vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            --     end,
            -- })
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
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = true,
    },
    {
        'folke/ts-comments.nvim',
        event = 'VeryLazy',
        config = true,
    },
}
