---@type LazyPluginSpec
local M = {
    'ThePrimeagen/harpoon',
    dependencies = { 'nvim-lua/plenary.nvim' },
    lazy = true,
    cond = false,
}

function M.keys(_, _)
    local mark = lreq('harpoon.mark')
    local ui = lreq('harpoon.ui')

    return {
        { '<S-M>', mark.add_file, mode = 'n' },
        { '<C-h>m', ui.toggle_quick_menu, mode = 'n' },
        { '<C-h>o', ui.nav_next, mode = 'n' },
        { '<C-h>i', ui.nav_prev, mode = 'n' },
    }
end

return M
