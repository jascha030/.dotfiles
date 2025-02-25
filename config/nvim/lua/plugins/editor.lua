---@type LazyPluginSpec[]
local M = {
    { 'f-person/git-blame.nvim' },
    {
        'nvim-lua/plenary.nvim',
        lazy = true,
    },
    {
        'petertriho/nvim-scrollbar',
        config = true,
    },
    {
        'luukvbaal/stabilize.nvim',
        config = true,
    },
    {
        'kylechui/nvim-surround',
        config = true,
        event = 'VeryLazy',
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
        opts = {
            input = {
                -- When true, <Esc> will close the modal - Defaults to true
                insert_only = false,
            },
        },
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
    {
        'stevearc/conform.nvim',
        config = function(_, _)
            require('jascha030.core.formatting')
        end,
        keys = {
            {
                '<C-l>',
                function()
                    require('conform').format()
                end,
                mode = { 'n', 'v' },
                desc = 'Format using conform.',
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
    {
        'mfussenegger/nvim-lint',
        event = { 'BufReadPre', 'BufNewFile' },
        cond = false,
        opts = {
            linters_by_ft = {
                php = { 'phpstan' },
            },
        },
        config = function(_, opts)
            local lint = require('lint')

            lint.linters_by_ft = opts.linters_by_ft

            vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost' }, {
                group = vim.api.nvim_create_augroup('lint', { clear = true }),
                callback = function()
                    lint.try_lint()
                end,
            })
        end,
    },
}

return M
