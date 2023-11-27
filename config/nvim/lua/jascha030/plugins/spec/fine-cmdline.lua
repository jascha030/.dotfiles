local lreq = require('jascha030.lreq')
local fineline = lreq('fine-cmdline')

local M = {
    'VonHeikemen/fine-cmdline.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    opts = {
        cmdline = {
            prompt = '  ',
        },
        popup = {
            position = {
                row = '40%',
                col = '50%',
            },
            size = {
                width = '30%',
            },
            relative = 'editor',
            border = {
                padding = {
                    top = 0,
                    bottom = 0,
                    left = 2,
                    right = 2,
                },
                style = 'rounded',
                text = {
                    top = ' Cmdline ',
                    top_align = 'center',
                },
            },
            win_options = {
                winhighlight = 'Normal:FineCmdlineFloat,FloatBorder:FineFloatBorder',
                winblend = 0,
            },
        },
        hooks = {
            set_keymaps = function(imap, _)
                local fn = fineline.fn

                imap('<Esc>', fn.close)
                imap('<C-c>', fn.close)
                imap('<Up>', fn.up_search_history)
                imap('<Down>', fn.down_search_history)
            end,
        },
    },
    config = function(_, opts)
        fineline.setup(opts)
    end,
    keys = {
        { ':', '<cmd>FineCmdline<CR>', mode = 'n', { noremap = true } },
    },
}

return M
