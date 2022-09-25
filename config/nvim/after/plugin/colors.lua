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
        for _, plugin in pairs(config.plugin_configs) do
            require('config.loader').load_all()
        end
    end,
})

