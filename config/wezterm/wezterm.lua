local wezterm = require('wezterm')

local is_night_time = function()
    if tonumber(os.date('%H')) >= 19 then
        return true
    else
        return false
    end
end

local get_colors = function()
    if is_night_time() then
        return require('colors.jascha030.wez.og').scheme
    else
        return require('colors.jascha030.wez.og_light').scheme
    end
end

local fonts = {
    size = 17.5,
    normal = wezterm.font('MesloLGS Nerd Font'),
    italic = wezterm.font('Dank Mono', {
        italic = true,
        weight = 500,
    }),
}

local font_rules = {
    {
        italic = false,
        intensity = 'Normal',
        font = wezterm.font_with_fallback({
            'nonicons',
            { family = 'MesloLGS Nerd Font', italic = false, weight = 600 },
        }),
    },
    {
        italic = true,
        intensity = 'Bold',
        font = fonts.normal,
    },
    {
        italic = true,
        intensity = 'Normal',
        font = fonts.italic,
    },
}

return {
    default_prog = { '/usr/local/bin/zsh', '--login' },

    window_decorations = 'NONE | RESIZE',
    window_padding = {
        left = 4,
        right = 4,
        top = 4,
        bottom = 0,
    },
    enable_tab_bar = false,

    default_cursor_style = 'BlinkingBlock',
    cursor_blink_rate = 250,
    cursor_blink_ease_in = 'Ease',
    cursor_blink_ease_out = 'Ease',

    colors = get_colors(),

    font = fonts.normal,
    font_with_fallback = fonts.with_fallback,
    font_rules = font_rules,
    font_size = fonts.size,
}
