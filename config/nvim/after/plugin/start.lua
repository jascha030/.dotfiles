local utils = require('utils')
local config = utils.conf

if config.colorscheme == 'nitepal' then
    utils.theme.init()
else
    vim.cmd('colorscheme ' .. config.colorscheme)
end

-- Plugin setups
utils.icons.setup(utils.conf.devicons)

-- Local setups
require('lsp').setup()

utils.create_packer_cmds()
