local wezterm = require('wezterm')
local theme = require('theme')
local fonts = require('fonts')

wezterm.on('window-config-reloaded', function(window)
    local current = window:get_appearance()
    local overrides = window:get_config_overrides() or {}
    local scheme = theme.get_scheme(current)

    if overrides.colors ~= scheme then
        overrides.colors = scheme
        overrides.window_background_opacity = theme.get_opacity(current)
        window:set_config_overrides(overrides)
    end
end)

local colors = theme.get_scheme('Dark', true)

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
    local background = colors.background
    local foreground = colors.foreground

    if tab.is_active then
        background = colors.foreground
        foreground = colors.background
    elseif hover then
        background = colors.foreground
        foreground = colors.ansi[2]
    end

    return {
        { Background = { Color = background } },
        { Foreground = { Color = foreground } },
        { Text = ' ' .. tab.active_pane.title .. ' ' },
    }
end)

return {
    default_prog = { '/usr/local/bin/zsh', '--login' },
    --enable_tab_bar = false,
    use_fancy_tab_bar = false,
    hide_tab_bar_if_only_one_tab = true,
    tab_bar_at_bottom = true,

    window_decorations = 'NONE | RESIZE',
    window_padding = { left = 0, right = 0, top = 0, bottom = 0 },

    window_frame = {
        active_titlebar_bg = colors.background,
        inactive_titlebar_bg = colors.background,
        inactive_titlebar_fg = colors.foreground,
        active_titlebar_fg = colors.ansi[2],
        inactive_titlebar_border_bottom = colors.background,
        active_titlebar_border_bottom = colors.background,
        button_fg = colors.foreground,
        button_bg = colors.background,
        button_hover_fg = colors.background,
        button_hover_bg = colors.foreground,
    },

    default_cursor_style = 'BlinkingBlock',
    cursor_blink_rate = 250,
    cursor_blink_ease_in = 'Ease',
    cursor_blink_ease_out = 'Ease',

    font_size = fonts.size,
    font_rules = fonts.rules,

    colors = colors,
    inactive_pane_hsb = { saturation = 0.98, brightness = 0.9 },
    window_background_opacity = theme.get_opacity('Dark'),

    keys = require('keymap'),
    disable_default_key_bindings = true,
    leader = { key = 'd', mods = 'CTRL' },
}
