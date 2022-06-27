local wezterm = require('wezterm')
local theme = require('theme')
local fonts = require('fonts')
local keys = require('keymap')

wezterm.on('window-config-reloaded', function(window, pane)
    local overrides = window:get_config_overrides() or {}
    local scheme = theme.get_scheme(window:get_appearance())

    if overrides.colors ~= scheme then
        overrides.colors = scheme
        window:set_config_overrides(overrides)
    end
end)

return {
    default_prog = { '/usr/local/bin/zsh', '--login' },

    leader = { key = 'd', mods = 'CTRL' },
    disable_default_key_bindings = true,
    keys = keys,

    enable_tab_bar = false,

    window_decorations = 'NONE | RESIZE',
    window_padding = { left = 10, right = 10, top = 6, bottom = 2 },

    default_cursor_style = 'BlinkingBlock',

    cursor_blink_rate = 250,
    cursor_blink_ease_in = 'Ease',
    cursor_blink_ease_out = 'Ease',

    font_size = fonts.size,
    font = fonts.default,
    font_rules = fonts.rules,

    colors = theme.get_scheme('Dark'),

    inactive_pane_hsb = {
        saturation = 0.7,
        brightness = 0.85,
    },

    scrollback_lines = 3500,
    window_background_opacity = 0.97,
}
