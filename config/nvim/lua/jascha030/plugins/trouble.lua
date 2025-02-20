---@type LazyPluginSpec
local M = {
    'folke/trouble.nvim',
    name = 'trouble',
    keys = {
        { 'TT', '<cmd>Trouble toggle diagnostics<cr>', mode = 'n', desc = 'Toggle Trouble' },
    },
    cmd = {
        'Trouble',
        'TroubleClose',
        'TroubleToggle',
        'TroubleRefresh',
    },
    opts = function(_, opts)
        return vim.tbl_deep_extend('force', opts or {}, {
            position = 'bottom',
            win_config = { border = BORDER },
            use_diagnostic_signs = true,
            picker = {
                actions = require('trouble.sources.snacks').actions,
                win = {
                    input = {
                        keys = {
                            ['<c-t>'] = {
                                'trouble_open',
                                mode = { 'n', 'i' },
                            },
                        },
                    },
                },
            },
        })
    end,
}

return M
