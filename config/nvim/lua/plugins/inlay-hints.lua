return {
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
}
