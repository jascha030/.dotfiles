return function()
    local devicons = require('nvim-web-devicons')
    local colors = require('colors').get_colors()

    local icons = {
        git = '',
        term = '',
        init = '⏻',
        bookmark = '',
        alias = '',
    }

    local function get(name)
        if not icons[name] then
            error('No icon defined for ' .. name)
        end

        return icons[name]
    end

    icons.get = get

    require('nvim-web-devicons').setup({
        default_icon = '',
        override = {},
    })

    devicons.set_icon({
        ['.zshrc'] = {
            icon = get('term'),
            color = colors.bright_magenta,
            name = 'Zshrc',
        },
        ['.antigenrc'] = {
            icon = get('term'),
            color = colors.yellow,
            name = 'Antigenrc',
        },
        ['.zshenv'] = {
            icon = get('term'),
            color = colors.magenta,
            name = 'Zshenv',
        },
        ['init'] = {
            icon = get('init'),
            color = colors.red,
        },
        ['aliases'] = {
            icon = get('alias'),
            color = colors.yellow,
        },
    })
end
