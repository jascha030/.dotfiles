local wezterm = require('wezterm')
local theme = require('colors')
local fonts = require('fonts')

wezterm.on('window-config-reloaded', function(window, pane)
    local overrides = window:get_config_overrides() or {}
    local scheme = get_scheme(window:get_appearance())

    if overrides.colors ~= scheme then
        overrides.colors = scheme
        window:set_config_overrides(overrides)
    end
end)

return {
    default_prog = { '/usr/local/bin/zsh', '--login' },

    enable_tab_bar = false,

    window_decorations = 'NONE | RESIZE',
    window_padding = { left = 6, right = 6, top = 6, bottom = 6 },

    default_cursor_style = 'BlinkingBlock',

    cursor_blink_rate = 250,
    cursor_blink_ease_in = 'Ease',
    cursor_blink_ease_out = 'Ease',

    font_size = fonts.size,
    font = fonts.default,
    font_rules = fonts.rules,

    colors = theme.get_scheme('Dark'),
}
