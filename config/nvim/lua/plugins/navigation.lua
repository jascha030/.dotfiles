---@type LazyPluginSpec[]
local M = {
    {
        'smoka7/hop.nvim',
        version = '*',
        name = 'hop',
        cmd = {
            'HopWord',
            'HopLine',
            'HopChar1',
            'HopChar2',
            'HopPattern',
        },
        keys = {
            { '<leader><Tab><Tab>', '<cmd>HopWord<cr>', desc = 'Hop Word' },
        },
        opts = {
            keys = 'etovxqpdygfblzhckisuran',
            jump_on_sole_occurrence = false,
        },
    },
    {
        'ThePrimeagen/harpoon',
        dependencies = { 'nvim-lua/plenary.nvim' },
        lazy = true,
        keys = function(_, _)
            local mark = lreq('harpoon.mark')
            local ui = lreq('harpoon.ui')

            return {
                { '<S-M>', mark.add_file, mode = 'n' },
                { '<C-h>m', ui.toggle_quick_menu, mode = 'n' },
                { '<C-h>o', ui.nav_next, mode = 'n' },
                { '<C-h>i', ui.nav_prev, mode = 'n' },
            }
        end,
    },
}

return M
