---@type LazyPluginSpec[]
local M = {
    { 'rcarriga/nvim-notify', opts = {} },
    {
        'folke/noice.nvim',
        event = { 'VeryLazy' },
        dependencies = {
            'folke/snacks.nvim',
            'MunifTanjim/nui.nvim',
            'rcarriga/nvim-notify',
        },
        opts = {
            routes = {},
            notify = { enabled = false },
            lsp = {
                progress = { enabled = false },
                message = { enabled = false },
                override = {
                    ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                    ['vim.lsp.util.stylize_markdown'] = true,
                    ['cmp.entry.get_documentation'] = true,
                },
                signature = {
                    enabled = true,
                    auto_open = {
                        enabled = true,
                        trigger = true,
                        throttle = 50,
                    },
                    opts = {},
                },
                hover = {
                    silent = true,
                    enabled = false,
                    border = {
                        style = BORDER,
                        padding = { 0, 0 },
                    },
                },
            },
            messages = {
                enabled = false, -- enables the Noice messages UI
                view = 'cmdline',
                view_error = 'mini', -- view for errors
                view_warn = 'mini', -- view for warnings
                view_history = 'messages', -- view for :messages
                view_search = 'virtualtext', -- view for search count messages. Set to `false` to disable
            },
            redirect = {},
            presets = {
                bottom_search = true, -- use a classic bottom cmdline for search
                command_palette = true, -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = true, -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = true, -- add a border to hover docs and signature help
            },
            views = {
                cmdline = { backend = 'popup' },
                cmdline_popup = {
                    position = {
                        row = '35%',
                        col = '50%',
                    },
                    border = {
                        style = BORDER,
                        padding = { 0, 0 },
                    },
                    win_options = {
                        winhighlight = {
                            Normal = 'NormalFloat',
                        },
                    },
                    size = {
                        -- width = math.floor(vim.api.nvim_win_get_width(0) / 2),
                        width = 'auto',
                        height = 'auto',
                    },
                },
            },
        },
    },
}

return M
