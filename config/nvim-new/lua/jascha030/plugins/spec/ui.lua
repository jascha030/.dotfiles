local lreq = require('jascha030.lreq')
local theme = lreq('jascha030.utils.theme')

local function get_background()
    return theme.is_dark() and '#1e2030' or '#e7e9ef'
end

return {
    -- { 'norcalli/nvim-colorizer.lua', lazy = true, name = 'colorizer' },
    {
        'brenoprata10/nvim-highlight-colors',
        name = 'nvim-highlight-colors',
        event = 'VeryLazy',
        opts = {
            render = 'first_column',
        },
    },
    {
        'goolord/alpha-nvim',
        event = 'VimEnter',
        opts = function()
            return require('alpha.themes.startify').config
        end,
        config = function(_, opts)
            require('alpha').setup(opts)
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
}
