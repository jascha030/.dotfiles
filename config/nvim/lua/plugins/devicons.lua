local devicons = require('nvim-web-devicons')
local colors = require('colors').get_colors()

local icons = {
    git = {
        icon = '',
        color = colors.bright_blue,
        cterm_color = '12',
    },
    term = {
        icon = '',
        color = colors.green,
        cterm_color = '71',
    },
}

require('nvim-web-devicons').setup({
    default_icon = '',
    override = {
        ['init'] = {
            icon = '⏻',
            color = colors.red,
            cterm_color = '1',
        },
    },
})

devicons.set_icon({
    zsh = {
        icons.term,
        color = colors.magenta,
    },
})
