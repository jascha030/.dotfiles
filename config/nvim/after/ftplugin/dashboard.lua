local db = require('dashboard')

db.custom_center = {
    {
        icon = '  ',
        desc = 'Recently latest session                  ',
        shortcut = 'SPC s l',
        action = 'SessionLoad',
    },
    {
        icon = '  ',
        desc = 'Recently opened files                   ',
        action = 'DashboardFindHistory',
        shortcut = 'SPC f h',
    },
    {
        icon = '  ',
        desc = 'Find  word                              ',
        action = 'Telescope live_grep',
        shortcut = 'SPC f w',
    },
}

-- db.custom_header = { 'test' }

-- db.preview_command = 'wezterm imgcat'
-- db.preview_file_path = os.getenv('DOTFILES') .. '/util/img/NVIM-PAK.png'
