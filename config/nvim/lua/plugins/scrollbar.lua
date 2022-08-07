return function()
    local colors = require('tokyonight.colors').setup({})
    --local user_colors = require('scheme.colors.jassie030')

    require('scrollbar').setup({
        handle = {
            --color = user_colors[DarkmodeEnabled() and 'dark' or 'light'],
        },
        marks = {
            Search = { color = colors.orange },
            Error = { color = colors.error },
            Warn = { color = colors.warning },
            Info = { color = colors.info },
            Hint = { color = colors.hint },
            Misc = { color = colors.purple },
        },
    })
end
