---@type LazyPluginSpec
local M = {
    dir = '~/.development/Projects/lua/nitepal.nvim',
    lazy = false,
    dependencies = {
        { 'hoob3rt/lualine.nvim' },
    },
    opts = {
        transparent = {
            background = true,
            floats = true,
            popups = true,
            sidebars = true,
        },
        contrast = true,
    },
    priority = 1000,
}

function M.config(_, opts)
    require('nitepal.config').extend(opts)

    ---@type ThemeUtil
    local theme = require('jascha030.utils.theme')
    local config = require('jascha030.core.config').options

    vim.api.nvim_create_autocmd('User', {
        group = vim.api.nvim_create_augroup('themeUpdate', { clear = true }),
        pattern = 'NitePalUpdateScheme',
        callback = function()
            require('plugins.devicons.config').init()

            --- Schedule full lualine re-setup to run after all ColorScheme
            --- and highlight operations have settled. A plain refresh() is
            --- insufficient because lualine's internal highlight cache
            --- (`loaded_highlights` in highlight.lua) can retain stale
            --- entries across the hi-clear → re-highlight cycle that
            --- nitepal performs.
            vim.schedule(function()
                require('lualine').setup()
            end)
        end,
    })

    if config.colorscheme == 'nitepal' or config.colorscheme == 'litepal' then
        theme.init()
    else
        vim.cmd('colorscheme ' .. config.colorscheme)
    end
end

return M
