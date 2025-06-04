---@diagnostic disable-next-line: unused-local
local theme = lreq('jascha030.utils.theme')

---@type LazyPluginSpec[]
local M = {
    {
        'brenoprata10/nvim-highlight-colors',
        name = 'nvim-highlight-colors',
        event = { 'VeryLazy' },
        opts = { render = 'first_column' },
    },
    {
        'm-demare/hlargs.nvim',
        opts = {
            color = '#ea1479',
            highlight = {},
            excluded_filetypes = {},
            paint_arg_declarations = true,
            paint_arg_usages = true,
            paint_catch_blocks = { declarations = false, usages = false },
            extras = { named_parameters = false },
            hl_priority = 10000,
            excluded_argnames = {
                declarations = {},
                usages = {
                    python = { 'self', 'cls' },
                    lua = { 'self' },
                    php = { 'self', 'static' },
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
    {
        'folke/paint.nvim',
        opts = {
            highlights = {
                {
                    filter = { filetype = 'lua' },
                    pattern = '%s*%-%-%-%s*(@%w+)',
                    hl = '@keyword',
                },
                {
                    filter = { filetype = 'zsh' },
                    pattern = 'function',
                    hl = '@keyword.function',
                },
                {
                    filter = { filetype = 'php' },
                    pattern = '%s*%*+%s*(@[^%s][^%s]*)',
                    hl = '@attribute.phpdoc',
                },
                {
                    filter = { filetype = 'php' },
                    pattern = '%s*%*+%s*@noinspection%s*([^%s][^%s]*)',
                    hl = '@type.phpdoc',
                },
                {
                    filter = { filetype = 'php' },
                    pattern = '%s*%*+%s*@phpstan%-[^%s][^%s]*%s*([^%s][^%s]*)',
                    hl = '@type.phpdoc',
                },
                {
                    filter = { filetype = 'php' },
                    pattern = '%s*%*+%s*@phpstan%-[^%s][^%s]*%s*[^%s][^%s]*%s*(%$)',
                    hl = '@keyword.phpdoc',
                },
                {
                    filter = { filetype = 'php' },
                    pattern = '%s*%*+%s*@phpstan%-[^%s][^%s]*%s*[^%s][^%s]*%s*%$(%w+)',
                    hl = '@variable.parameter.phpdoc',
                },
            },
        },
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        ft = 'markdown',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'echasnovski/mini.nvim',
        },
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {
            preset = 'lazy',
            completions = { blink = { enabled = true } },
        },
    },
    {
        'Bekaboo/dropbar.nvim',
        dependencies = {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
        },
        config = function()
            local dropbar_api = require('dropbar.api')
            vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
            vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
            vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })
        end,
    },
}

return M
