local font = require('fonts')
local handlers = require('handlers')

font.extend({
    main = 'MesloLGS Nerd Font',
    alt = 'Dank Mono',
    italic = 'Dank Mono',
})

handlers.setup()

return {
    default_prog = { '/usr/local/bin/zsh', '--login' },
    window_decorations = 'NONE | RESIZE',
    window_padding = { left = 2.5, right = 2.5, top = 0, bottom = 0 },
    window_frame = {
        button_fg = handlers.options.colors.foreground,
        button_bg = handlers.options.colors.background,
        button_hover_fg = handlers.options.colors.background,
        button_hover_bg = handlers.options.colors.foreground,
    },
    enable_tab_bar = true,
    use_fancy_tab_bar = false,
    tab_bar_at_bottom = true,
    show_tab_index_in_tab_bar = true,
    hide_tab_bar_if_only_one_tab = true,
    default_cursor_style = 'BlinkingBlock',
    cursor_blink_rate = 250,
    cursor_blink_ease_in = 'Ease',
    cursor_blink_ease_out = 'Ease',
    cursor_thickness = '150%',
    line_height = font.options.line_height,
    font_size = font.options.size,
    font_rules = font.get_rules(false),
    colors = handlers.options.colors,
    inactive_pane_hsb = { saturation = 0.98, brightness = 0.9 },
    window_background_opacity = 1,
    keys = require('keymap'),
    disable_default_key_bindings = true,
    leader = { key = 'd', mods = 'CTRL' },
}
