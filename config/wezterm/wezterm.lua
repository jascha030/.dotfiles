local wezterm = require('wezterm')
local theme = require('theme')
local fonts = require('fonts')
local colors = theme.get_scheme('Dark', true)

wezterm.on('window-config-reloaded', function(window)
    local current = window:get_appearance()
    local overrides = window:get_config_overrides() or {}

    colors = theme.get_scheme(current, true)
    local scheme = colors

    if overrides.colors ~= scheme then
        overrides.colors = scheme
        overrides.window_background_opacity = theme.get_opacity(current)
        window:set_config_overrides(overrides)
    end
end)

local function is_table(value)
    return type(table) == 'table'
end

local function assert_table(value, error)
    if not is_table(value) then
        error(error or 'Argument should be of type "table".', 2)
    end
end

local function tbl_count(table)
    assert_table(table)
    local c = 0

    for _, _ in ipairs(table) do
        c = c + 1
    end

    return c
end

local proc_icons = {
    ['default'] = ' ',
    ['nvim'] = ' ',
}

local style = {}

function style.bg_style(c, invert)
    return { Foreground = { Color = invert == true and c.background or c.foreground } }
end

function style.fg_style(c, invert)
    return { Background = { Color = invert == true and c.foreground or c.background } }
end

function style.icon(process_name)
    return proc_icons[process_name] and proc_icons[process_name] .. ' ' or proc_icons['default']
end

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
    local title_icon = style.icon(proc_icons[tab.active_pane.title])
    local title = ' ' .. tab.tab_index + 1 .. ': ' .. title_icon .. tab.active_pane.title .. ' '

    local last = tbl_count(tabs) == tab.tab_index + 1
    local first = tab.tab_index == 0
end)

return {
    default_prog = { '/usr/local/bin/zsh', '--login' },

    window_decorations = 'NONE | RESIZE',
    window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
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

    font_size = fonts.size,
    font_rules = fonts.rules,

    colors = colors,
    inactive_pane_hsb = { saturation = 0.98, brightness = 0.9 },
    window_background_opacity = theme.get_opacity('Dark'),

    keys = require('keymap'),
    disable_default_key_bindings = true,
    leader = { key = 'd', mods = 'CTRL' },
}
