return function()
    local ok, colorscheme = pcall(require, 'colorschemes.jassie030')
    if not ok then
        require('nvim-web-devicons').setup({})

        return
    end

    local colors = colorscheme.get_scheme().dark

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
            --['gitignore_global'] = icons.git,
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
