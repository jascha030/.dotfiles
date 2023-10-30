local wezterm = require('wezterm')
local theme = require('theme')
local font = require('fonts')
local handlers = require('handlers')

local proc_icons = {
    ['default'] = ' ',
    ['nvim'] = ' ',
}

local colors = theme.get_scheme('Dark', true)

font.extend({
    main = 'Cascadia Code',
    alt = 'Dank Mono',
    italic = 'Cascadia Code',
})

handlers.setup()

local function icon(process_name)
    return proc_icons[process_name] and proc_icons[process_name] .. ' ' or proc_icons['default']
end

wezterm.on('window-config-reloaded', function(window)
    local current = window:get_appearance()
    local overrides = window:get_config_overrides() or {}

    colors = theme.get_scheme(current, true)
    handlers.set_colors(colors)

    if overrides.colors ~= colors then
        overrides.colors = colors
        window:set_config_overrides(overrides)
    end
end)

wezterm.on('format-tab-title', function(tab)
    local title_icon = icon(tab.active_pane.title)
    local title = ' ' .. tab.tab_index + 1 .. ': ' .. title_icon .. tab.active_pane.title .. ' '
    local first = tab.tab_index == 0

    local c = {
        fg = tab.is_active and colors.foreground or colors.background,
        bg = tab.is_active and colors.background or colors.foreground,
    }

    return not first
            and {
                { Foreground = { Color = colors.background } },
                { Background = { Color = colors.foreground } },
                { Text = ' ' },
                { Foreground = { Color = colors.background } },
                { Background = { Color = colors.foreground } },
                { Text = ' ' },
                { Foreground = { Color = c.fg } },
                { Background = { Color = c.bg } },
                { Text = title },
            }
        or {
            { Foreground = { Color = c.fg } },
            { Background = { Color = c.bg } },
            { Text = ' ' },
            { Foreground = { Color = c.fg } },
            { Background = { Color = c.bg } },
            { Text = title },
        }
end)

local function eq_pad(size, alt, cell)
    alt = alt or size
    cell = cell or false

    if cell == false then
        return {
            top = size,
            right = alt,
            bottom = size,
            left = alt,
        }
    end

    return {
        top = size .. 'cell',
        right = alt .. 'cell',
        bottom = size .. 'cell',
        left = alt .. 'cell',
    }
end

return {
    default_prog = { '/bin/zsh', '--login' },
    window_decorations = 'NONE | RESIZE',
    window_padding = eq_pad(0.1, 1, true),
    window_frame = {
        button_fg = colors.foreground,
        button_bg = colors.background,
        button_hover_fg = colors.background,
        button_hover_bg = colors.foreground,
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
    colors = theme.get_scheme('Dark', true),
    inactive_pane_hsb = { saturation = 0.98, brightness = 0.9 },
    window_background_opacity = handlers.options.opacity,
    macos_window_background_blur = 70,
    keys = require('keymap'),
    disable_default_key_bindings = true,
    leader = { key = 'd', mods = 'CTRL' },
    harfbuzz_features = {
        'zero', -- Use a slashed zero '0' (instead of dotted)
        'kern', -- (default) kerning (todo check what is really is)
        'liga', -- (default) ligatures
        'clig', -- (default) contextual ligatures
    },
}
