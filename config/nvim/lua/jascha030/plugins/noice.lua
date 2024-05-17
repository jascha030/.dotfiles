---@type LazyPluginSpec
local M = {
    'folke/noice.nvim',
    event = 'VeryLazy',
    -- cond = false,
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
                silent = true, -- set to true to not show a message if hover is not available
                opts = {}, -- merged with defaults from documentation
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
            -- opts = {
            --     enter = false,
            --     replace = true,
            -- },
        },
        messages = {
            enabled = false, -- enables the Noice messages UI
            view = 'cmdline',
            -- view = 'cmdline', -- default view for messages
            view_error = 'mini', -- view for errors
            view_warn = 'mini', -- view for warnings
            view_history = 'messages', -- view for :messages
            view_search = 'virtualtext', -- view for search count messages. Set to `false` to disable
        },
        redirect = {},
        presets = {
            bottom_search = true, -- use a classic bottom cmdline for search
            command_palette = true, -- position the cmdline and popupmenu together
            -- long_message_to_split = true, -- long messages will be sent to a split
            -- inc_rename = true, -- enables an input dialog for inc-rename.nvim
            -- lsp_doc_border = true, -- add a border to hover docs and signature help
        },
        views = {},
    },
}

return M
