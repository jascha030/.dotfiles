local lreq = require('jascha030.lreq')

local M = {
    'ThePrimeagen/harpoon',
    dependencies = { 'nvim-lua/plenary.nvim' },
    lazy = true,
}

function M.keys(_, _)
    local mark = lreq('harpoon.mark')
    local ui = lreq('harpoon.ui')

    return {
        { '<S-M>', mark.add_file, mode = 'n' },
        { '<leader>hm', ui.toggle_quick_menu, mode = 'n' },
        { '<leader>ho', ui.nav_next, mode = 'n' },
        { '<leader>h[', ui.nav_prev, mode = 'n' },
    }
end

return M
