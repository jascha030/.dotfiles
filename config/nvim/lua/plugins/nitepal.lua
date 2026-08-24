---@type LazyPluginSpec
local M = {
    dir = '~/.development/Projects/lua/nitepal.nvim',
    lazy = false,
    dependencies = {
        { 'hoob3rt/lualine.nvim' },
    },
    opts = {
		colorscheme = 'nitepal',
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

    vim.api.nvim_create_autocmd('User', {
        group = vim.api.nvim_create_augroup('themeUpdate', { clear = true }),
        pattern = 'NitePalUpdateScheme',
        callback = function()
            ---@diagnostic disable-next-line: missing-parameter
            require('plugins.devicons').refresh()

            --- Schedule full lualine re-setup to run after all ColorScheme
            --- and highlight operations have settled. A plain refresh() is
            --- insufficient because lualine's internal highlight cache
            --- (`loaded_highlights` in highlight.lua) can retain stale
            --- entries across the hi-clear → re-highlight cycle that
            --- nitepal performs.
            vim.schedule(function()
                require('lualine').setup({})
            end)
        end,
    })

    if opts.colorscheme == 'nitepal' or opts.colorscheme == 'litepal' then
        theme.init()
    else
        vim.cmd('colorscheme ' .. opts.colorscheme)
    end
end

return M
