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
}

return M
