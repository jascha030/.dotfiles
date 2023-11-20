local M = {
    'folke/noice.nvim',
    event = 'VeryLazy',
    cond = false,
    dependencies = {
        'MunifTanjim/nui.nvim',
        'rcarriga/nvim-notify',
    },
    opts = {
        routes = {
            {
                filter = {
                    event = 'msg_show',
                    kind = '',
                    find = 'written',
                },
                opts = {
                    skip = true,
                },
            },
        },
        notify = {
            enabled = false,
        },
        lsp = {
            hover = {
                enabled = true,
            },
            progress = {
                enabled = false,
            },
            message = {
                enabled = false,
            },
            override = {
                ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                ['vim.lsp.util.stylize_markdown'] = true,
                ['cmp.entry.get_documentation'] = true,
            },
            signature = {
                enabled = false,
            },
        },
        cmdline = {
            enabled = true,
        },
        redirect = {

        },
        presets = {
            bottom_search = true, -- use a classic bottom cmdline for search
            -- command_palette = true, -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = true, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = true, -- add a border to hover docs and signature help
        },
    },
}

return M
