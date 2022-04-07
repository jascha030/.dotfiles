local wezterm = require('wezterm')

local fonts = {
    size = 17.0,
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
        font = wezterm.font('MesloLGS Nerd Font', {
            italic = false,
            weight = 600,
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

    colors = require('colors.jascha030.wez.og'),

    font = fonts.normal,
    font_rules = font_rules,
    font_size = fonts.size,
}
