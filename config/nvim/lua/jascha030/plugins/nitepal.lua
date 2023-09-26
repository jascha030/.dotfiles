local M = {
    dir = '~/.development/Projects/Lua/nitepal.nvim',
    dependencies = {
        'hoob3rt/lualine.nvim',
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

    -- @type Utils theme
    local theme = require('jascha030.utils.theme')
    local config = require('jascha030.config').options

    require('nitepal.config').extend(opts)

    if config.colorscheme == 'nitepal' then
        theme.init()
    else
        vim.cmd('colorscheme ' .. config.colorscheme)
    end

    -- Auto change colorscheme on MacOS Light/Darkmode change.
    vim.api.nvim_create_autocmd('Signal', {
        pattern = 'SIGUSR1',
        callback = function()
            theme.theme.set_from_os()

            require('config.loader').load_all()
            require('lualine').refresh()
        end,
    })
end

return M
