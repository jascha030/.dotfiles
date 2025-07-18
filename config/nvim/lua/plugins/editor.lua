---@type LazyPluginSpec[]
local M = {
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
    {
        'sheerun/vim-polyglot',
        -- cond = false,
    },
}

return M
