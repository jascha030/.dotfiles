local M = {
    dir = '/Users/jaschavanaalst/.development/Projects/Lua/nitepal.nvim',
    name = 'nitepal',
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
}

function M.config(_, opts)
    vim.o.runtimepath = vim.o.runtimepath .. ',' .. os.getenv('XDG_CONFIG_HOME')

    require('nitepal.config').extend(opts)

    ---@type ThemeUtil
    local theme = require('jascha030.utils.theme')
    local config = require('jascha030.config').options

    if config.colorscheme == 'nitepal' then
        theme.init()
    else
        vim.cmd('colorscheme ' .. config.colorscheme)
    end

    -- Auto change colorscheme on MacOS Light/Darkmode change.
    vim.api.nvim_create_autocmd('Signal', {
        pattern = 'SIGUSR1',
        callback = function()
            theme.set_from_os()

            require('jascha030.plugins.devicons.config').init()
            -- .setup(require('jascha030').get_config('devicons'))
            require('lualine').refresh()
        end,
    })
end

return M
