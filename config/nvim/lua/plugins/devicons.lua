return function()
    require('nvim-web-devicons').setup({
        default_icon = '',
        override = {
            ['.zshrc'] = {
                icon = '',
                color = '#31B53E',
                cterm_color = '71',
                name = 'Terminal',
            },
            ['.zprofile'] = {
                icon = '',
                color = '#31B53E',
                cterm_color = '71',
                name = 'Terminal',
            },
            ['.zshenv'] = {
                icon = '',
                color = '#31B53E',
                cterm_color = '71',
                name = 'Terminal',
            },
        },
    })
end
