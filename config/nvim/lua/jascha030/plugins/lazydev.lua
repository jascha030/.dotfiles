---@type LazyPluginSpec[]
local M = {
    {
        'folke/lazydev.nvim',
        ft = 'lua', -- only load on lua files
        cond = false,
        opts = {
            debug = true,
            library = {
                { path = 'luvit-meta/library', words = { 'vim%.uv', 'vim%.loop' } },
                { path = 'LazyVim', words = { 'LazyVim' } },
            },
        },
    },
    {
        'Bilal2453/luvit-meta',
        lazy = true,
        cond = false,
    }, -- optional `vim.uv` typings
}

return M
