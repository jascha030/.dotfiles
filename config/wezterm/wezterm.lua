local wezterm = require('wezterm')
local theme = require('theme')
local font = require('fonts')

local MESLO = 'MesloLGS Nerd Font'
local DANK = 'Dank Mono'

local proc_icons = {
    ['default'] = ' ',
    ['nvim'] = ' ',
}

local function icon(process_name)
    return proc_icons[process_name] and proc_icons[process_name] .. ' ' or proc_icons['default']
end

local colors = theme.get_scheme('Dark', true)
local opacity = 1

wezterm.on('window-config-reloaded', function(window)
    local current = window:get_appearance()
    local overrides = window:get_config_overrides() or {}

    colors = theme.get_scheme(current, true)

    if overrides.colors ~= colors then
        overrides.colors = colors
        window:set_config_overrides(overrides)
    end
end)

wezterm.on('opacity-up', function(window, _)
    local overrides = window:get_config_overrides() or {}
    local current = overrides.window_background_opacity or opacity

    if current >= 1 then
        return
    end

    overrides.window_background_opacity = (current + 0.01)
    window:set_config_overrides(overrides)
end)

wezterm.on('opacity-down', function(window, _)
    local overrides = window:get_config_overrides() or {}
    local current = overrides.window_background_opacity or opacity

    if current <= 0 then
        return
    end

    overrides.window_background_opacity = (current - 0.01)
    window:set_config_overrides(overrides)
end)

wezterm.on('resize-font-up', function(window, _)
    local overrides = window:get_config_overrides() or {}
    local current = overrides.font_size or font.default_size

    overrides.font_size = (current + 0.5)
    window:set_config_overrides(overrides)
end)

wezterm.on('resize-font-down', function(window, _)
    local overrides = window:get_config_overrides() or {}
    local current = overrides.font_size or font.default_size

    overrides.font_size = (current - 0.5)
    window:set_config_overrides(overrides)
end)

wezterm.on('reset-font', function(window, _)
    local overrides = window:get_config_overrides() or {}

    overrides.font_size = font.default_size
    window:set_config_overrides(overrides)
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
                { Text = '┇' },
                { Foreground = { Color = c.fg } },
                { Background = { Color = c.bg } },
                { Text = title },
            }
        or {
            { Foreground = { Color = c.fg } },
            { Background = { Color = c.bg } },
            { Text = title },
        }
end)

return {
    default_prog = { '/usr/local/bin/zsh', '--login' },
    window_decorations = 'NONE | RESIZE',
    window_padding = { left = 2.5, right = 2.5, top = 0, bottom = 0 },
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

    line_height = 1.35,
    font_size = font.get(MESLO, DANK).size,
    font_rules = font.get(MESLO, DANK).rules,
    colors = colors,
    inactive_pane_hsb = { saturation = 0.98, brightness = 0.9 },
    window_background_opacity = 1,
    keys = require('keymap'),
    disable_default_key_bindings = true,
    leader = { key = 'd', mods = 'CTRL' },
}
