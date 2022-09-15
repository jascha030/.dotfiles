local utils = require('utils')
local config = utils.conf

if config.colorscheme == 'nitepal' then
    utils.theme.init()
else
    vim.cmd('colorscheme ' .. config.colorscheme)
end

vim.api.nvim_create_autocmd('Signal', {
    pattern = 'SIGUSR1',
    callback = function()
        if utils == nil then
            utils = require('utils')
        end

        utils.theme.set_from_os()

        -- TODO: autoload based on files in config dir.
        for _, plugin in pairs({
            'nvim-tree',
            'lualine',
            'cokeline',
            'alpha',
            'indent_blankline',
        }) do
            require('config.loader').load(plugin)
        end

        require('nvim-web-devicons').set_up_highlights()
    end,
})

-- Plugin setups
utils.icons.setup(utils.conf.devicons)
