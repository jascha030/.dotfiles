---@type LazyPluginSpec
local M = {
    'folke/trouble.nvim',
    name = 'trouble',
    keys = {
        { 'TT', '<cmd>Trouble toggle diagnostics<cr>', mode = 'n', desc = 'Toggle Trouble'  },
    },
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
