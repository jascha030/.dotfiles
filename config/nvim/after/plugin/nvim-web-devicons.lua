local utils = require('utils')

require('nvim-web-devicons').setup({
    default_icon = require('utils').conf.devicons.default_icon,
})

utils.icons.setup(utils.conf.devicons)
