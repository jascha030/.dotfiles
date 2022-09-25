local wilder = nil

return function()
    if wilder == nil then
        wilder = require('wilder')
    end

    wilder.setup({ modes = { ':', '/', '?' } })

    wilder.set_option(
        'renderer',
        wilder.popupmenu_renderer(wilder.popupmenu_palette_theme({
            border = 'rounded',
            max_height = '50%', -- max height of the palette
            min_height = 0, -- set to the same as 'max_height' for a fixed height window
            -- prompt_position = 'bottom',
            prompt_position = 'top',
            reverse = 0,
        }))
    )
end
