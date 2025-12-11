---@type LazyPluginSpec[]
local M = {
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = true,
        opts = { disable_in_macro = false },
    },
    { 'f-person/git-blame.nvim' },
    { 'nvim-lua/plenary.nvim', lazy = true },
    { 'petertriho/nvim-scrollbar', config = true },
    { 'luukvbaal/stabilize.nvim', config = true },
    {
        'kylechui/nvim-surround',
        config = true,
        event = { 'VeryLazy' },
    },
    {
        'terrortylor/nvim-comment',
        name = 'nvim_comment',
        config = true,
        event = { 'VeryLazy' },
    },
    {
        'stevearc/dressing.nvim',
        dependencies = { 'MunifTanjim/nui.nvim' },
        event = 'VeryLazy',
        opts = { input = { insert_only = false } },
        init = function()
            ---@diagnostic disable-next-line: duplicate-set-field different-requires
            vim.ui.select = function(...)
                require('lazy').load({ plugins = { 'dressing.nvim' } })
                return vim.ui.select(...)
            end

            ---@diagnostic disable-next-line: duplicate-set-field different-requires
            vim.ui.input = function(...)
                require('lazy').load({ plugins = { 'dressing.nvim' } })
                return vim.ui.input(...)
            end
        end,
    },
    { 'wakatime/vim-wakatime' },
    { 'chr4/nginx.vim', ft = 'nginx' },
    { 'b0o/schemastore.nvim', ft = { 'json', 'yaml', 'yml' } },
    {
        'saecki/crates.nvim',
        event = { 'BufRead Cargo.toml' },
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = true,
        lazy = true,
    },
    { 'justinsgithub/wezterm-types' },
    {
        'iamcco/markdown-preview.nvim',
        build = 'cd app && yarn install',
        init = function()
            vim.g.mkdp_filetypes = { 'markdown' }
        end,
        cmd = {
            'MarkdownPreviewToggle',
            'MarkdownPreview',
            'MarkdownPreviewStop',
        },
        ft = { 'markdown' },
        keys = {
            {
                '<leader><leader>mp',
                '<Plug>MarkdownPreview<CR>',
                ft = 'markdown',
                desc = 'Toggle markdown preview',
            },
            {
                '<leader><leader>mt',
                '<Plug>MarkdownPreviewToggle<CR>',
                ft = 'markdown',
                desc = 'Toggle markdown preview',
            },
            {
                '<leader><leader>mq',
                '<Plug>MarkdownPreviewStop<CR>',
                ft = 'markdown',
                desc = 'Stop markdown preview',
            },
        },
    },
    {
        'ziontee113/color-picker.nvim',
        cmd = { 'PickColor', 'PickColorInsert' },
    },
    {
        'lvimuser/lsp-inlayhints.nvim',
        cond = not (vim.fn.has('nvim-0.10') == 1),
        opts = {
            inlay_hints = {
                parameter_hints = {
                    show = true,
                    prefix = '<-- ',
                    separator = ', ',
                    remove_colon_start = false,
                    remove_colon_end = true,
                },
                type_hints = {
                    show = true,
                    prefix = ': ',
                    separator = ', ',
                    remove_colon_start = false,
                    remove_colon_end = false,
                },
                only_current_line = true,
                labels_separator = '  ',
                max_len_align = true,
                max_len_align_padding = 1,
                highlight = 'LspInlayHint',
                priority = 0,
            },
        },
    },
    { 'sheerun/vim-polyglot' },
    {
        'smoka7/hop.nvim',
        version = '*',
        name = 'hop',
        cmd = { 'HopWord', 'HopLine', 'HopChar1', 'HopChar2', 'HopPattern' },
        keys = {
            { '<leader><Tab><Tab>', '<cmd>HopWord<cr>', desc = 'Hop Word' },
        },
        opts = {
            keys = 'etovxqpdygfblzhckisuran',
            jump_on_sole_occurrence = false,
        },
    },
    {
        'ThePrimeagen/harpoon',
        dependencies = { 'nvim-lua/plenary.nvim' },
        lazy = true,
        keys = function(_, _)
            local mark = lreq('harpoon.mark')
            local ui = lreq('harpoon.ui')

            return {
                { '<S-M>', mark.add_file, mode = 'n' },
                { '<C-h>m', ui.toggle_quick_menu, mode = 'n' },
                { '<C-h>o', ui.nav_next, mode = 'n' },
                { '<C-h>i', ui.nav_prev, mode = 'n' },
            }
        end,
    },
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
