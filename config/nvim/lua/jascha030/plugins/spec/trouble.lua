local M = {
    'folke/trouble.nvim',
    name = 'trouble',
    keys = {
        { 'TT', '<cmd>Trouble<cr>', mode = 'n', desc = 'Toggle Trouble'  },
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


-- function M.config(_, opts)
--     vim.api.nvim_create_autocmd('FileType', {
--         pattern = 'Trouble',
--        
--     })
--     require('trouble').setup(opts)
-- end
--
-- function M.keys(_, _)
--     local map_opts = { noremap = true, buffer = 0 }
--
--     return {
--         { 'n', 'TT', '<cmd>Trouble<cr>', map_opts },
--         { 'n', 'TT', '<cmd>Trouble<cr>', map_opts },
--     }
-- end

return M
