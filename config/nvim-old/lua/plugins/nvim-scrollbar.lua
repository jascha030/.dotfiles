return function ()
    local module = 'scrollbar'
    local colors = require('colors').get_colors()

    require(module).setup({
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
