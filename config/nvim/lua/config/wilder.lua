local wilder = nil

return function()
    if wilder == nil then
        wilder = require('wilder')
    end

    wilder.setup({ modes = { ':', '/', '?' } })
    wilder.set_option(
        'renderer',
        wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
            highlights = {
                border = 'Normal', -- highlight to use for the border
            },
            -- 'single', 'double', 'rounded' or 'solid'
            -- can also be a list of 8 characters, see :h wilder#popupmenu_border_theme() for more details
            border = 'rounded',
        }))
    )
end
