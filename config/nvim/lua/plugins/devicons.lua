return function()
    local colors = require('colors')

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
            ['.zshrc'] = icons.term,
            ['.zprofile'] = icons.term,
            ['.zshenv'] = icons.term,
            ['init'] = {
                icon = '⏻',
                color = colors.red,
                cterm_color = '1',
            },
            --['hushlogin'] = {
            --    icon = '',
            --    color = colors.bright_black,
            --    cterm_color = '8',
            --    name = 'Muted',
            --},
        },
    })
end
