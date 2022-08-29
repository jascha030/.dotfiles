return function()
    local bg = vim.o.background
    local devicons = require('nvim-web-devicons')
    local colors = require('nitepal.colors').get_colors()[bg or 'dark']

    local icons = {
        alias = '',
        asterisk = '',
        bookmark = '',
        brush = '',
        calendar = '',
        computer = '',
        database = '',
        documentation = '',
        editor = '',
        fileinfo = '',
        finder = '',
        git = '',
        git_sync = '',
        git_branch = '',
        git_merge = '',
        git_reject = '',
        ignore = '',
        init = '⏻',
        key = '',
        list = '',
        loadspeaker = '',
        mac = '',
        mute = '',
        pin = '',
        rocket = '',
        scholar = '',
        telescope = ' ',
        term = '',
        wrench = '',
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
    })

    local ignore = {
        icon = get('ignore'),
        color = colors.black,
        name = 'Ignore',
    }

    local git_config = {
        icon = get('git'),
        color = colors.additional.git_orange,
        name = 'GitConfig',
    }

    devicons.set_icon({
        ['.editorconfig'] = {
            icon = get('editor'),
            color = colors.yellow,
            name = 'EditorConfig',
        },
        ['.zshrc'] = {
            icon = get('term'),
            color = colors.magenta,
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
            name = 'Init',
        },
        ['init.lua'] = {
            icon = get('init'),
            color = colors.magenta,
            name = 'InitLua',
        },
        ['.macos'] = {
            icon = get('finder'),
            colors = colors.magenta,
            name = 'MacOs',
        },
        ['aliases'] = {
            icon = get('alias'),
            color = colors.yellow,
            name = 'Alias',
        },
        ['auto-ls'] = {
            icon = get('fileinfo'),
            color = colors.cyan,
            name = 'Autols',
        },
        ['fzf'] = {
            icon = get('telescope'),
            color = colors.red,
            name = 'Fzf',
        },
        ['hushlogin'] = {
            icon = get('mute'),
            color = colors.black,
            name = 'Hushlogin',
        },
        ['.gitignore'] = ignore,
        ['gitignore_global'] = ignore,
        ['gitconfig'] = git_config,
        ['.gitconfig'] = git_config,
        ['.styluaignore'] = ignore,
        ['my.cnf'] = {
            icon = get('database'),
            color = colors.blue,
            name = 'MyCnf',
        },
        ['README.md'] = {
            icon = get('documentation'),
            color = colors.red,
            name = 'README',
        },
        ['starship.toml'] = {
            icon = get('rocket'),
            color = colors.magenta,
            name = 'Starship',
        },
    })
end
