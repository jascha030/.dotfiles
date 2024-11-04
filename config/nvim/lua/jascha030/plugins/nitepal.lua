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
            require('jascha030.plugins.devicons.config').init()
            require('lualine').refresh()
        end,
    })

    if config.colorscheme == 'nitepal' or config.colorscheme == 'litepal' then
        theme.init()
    else
        vim.cmd('colorscheme ' .. config.colorscheme)
    end
end

return M
