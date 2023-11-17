local M = {
    'folke/trouble.nvim',
    keys = { { 'TT', '<cmd>TroubleToggle<cr>', mode = 'n', desc = 'Toggle Trouble' } },
    -- keys = {
    -- { 'TT', '<cmd>TroubleClose<CR>', mode = 'n', ft = 'Trouble', desc = 'Close Trouble Diagnostics window' },
    -- },
    cmd = {
        'Trouble',
        'TroubleClose',
        'TroubleToggle',
        'TroubleRefresh',
    },
    opts = {
        position = 'bottom',
        win_config = { border = BORDER },
        use_diagnostic_signs = true,
    },
}

return M
