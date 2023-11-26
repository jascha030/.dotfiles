local M = {
    'VonHeikemen/fine-cmdline.nvim',
    dependencies = {
        'MunifTanjim/nui.nvim',
    },
    opts = {
        popup = {
            position = {
                row = '30%',
                col = '50%',
            },
            size = {
                width = '40%',
            },
            border = {
                style = 'rounded',
            },
            win_options = {
                winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
            },
        },
    },
    config = function(_, opts)
        require('fine-cmdline').setup(opts)
    end,
    keys = {
        {
            ':',
            '<cmd>FineCmdline<CR>',
            mode = 'n',
            { noremap = true },
        },
    },
}

return M
