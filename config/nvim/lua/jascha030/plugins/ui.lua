local function get_background()
    return require('jascha030.utils.theme').is_dark() and '#1e2030' or '#e7e9ef'
end

return {
    {
        'sheerun/vim-polyglot',
        lazy = true,
    },
    {
        'yamatsum/nvim-cursorline',
        opts = {
            cursorline = {
                enable = true,
                timeout = 1000,
                number = false,
            },
            cursorword = {
                enable = true,
                min_length = 3,
                hl = { underline = true },
            },
        },
    },
    {
        'brenoprata10/nvim-highlight-colors',
        name = 'nvim-highlight-colors',
        event = 'VeryLazy',
        opts = { render = 'first_column' },
    },
    {
        'goolord/alpha-nvim',
        event = 'VimEnter',
        config = function(_, _)
            require('alpha').setup(require('alpha.themes.startify').config)
        end,
    },
    {
        'stevearc/dressing.nvim',
        event = 'VeryLazy',
        init = function()
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.select = function(...)
                require('lazy').load({ plugins = { 'dressing.nvim' } })
                return vim.ui.select(...)
            end
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.input = function(...)
                require('lazy').load({ plugins = { 'dressing.nvim' } })
                return vim.ui.input(...)
            end
        end,
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
                    filter = { filetype = 'php' },
                    pattern = '%s*%*% %s*(@%w+)',
                    hl = '@keyword',
                },
            },
        },
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
        'folke/noice.nvim',
        event = 'VeryLazy',
        dependencies = { 'MunifTanjim/nui.nvim', 'rcarriga/nvim-notify' },
        opts = {
            routes = { { filter = { event = 'msg_show', kind = '', find = 'written' }, opts = { skip = true } } },
            notify = { enabled = false },
            lsp = {
                hover = { enabled = true },
                progress = { enabled = false },
                message = { enabled = false },
                override = {
                    ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                    ['vim.lsp.util.stylize_markdown'] = true,
                    ['cmp.entry.get_documentation'] = true,
                },
                signature = { enabled = false },
            },
            presets = {
                bottom_search = true, -- use a classic bottom cmdline for search
                command_palette = true, -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = true, -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = true, -- add a border to hover docs and signature help
            },
        },
    },
    {
        'rcarriga/nvim-notify',
        cond = false,
        keys = {
            {
                '<leader>un',
                function()
                    require('notify').dismiss({ silent = true, pending = true })
                end,
                desc = 'Delete all Notifications',
            },
        },
        opts = {
            background_colour = get_background(),
            timeout = 2000,
            stages = 'static',
            max_height = function()
                return math.floor(vim.o.lines * 0.75)
            end,
            max_width = function()
                return math.floor(vim.o.columns * 0.75)
            end,
        },
    },
    {
        'norcalli/nvim-colorizer.lua',
        lazy = true,
        name = 'colorizer',
    },
}
