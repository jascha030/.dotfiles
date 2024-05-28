local wezterm = require('wezterm')
local font = require('fonts')
local theme = require('theme')
local colorscheme = theme.get_scheme('Dark', true)

local M = {}

M.options = {
    opacity = 0.95,
    colors = {},
    alt_font_active = false,
    editor_mode_active = false,
    proc_icons = {
        ['default'] = ' ',
        ['nvim'] = ' ',
    },
}

function M.set_colors(colors)
    M.options.colors = colors
end

function M.on_config_reloaded(window, _)
    local current = window:get_appearance()
    local overrides = window:get_config_overrides() or {}
    local prev_state = M.options.colors

    colorscheme = theme.get_scheme(current, true)
    M.set_colors(current)

    if prev_state ~= current then
        overrides.colors = colorscheme
        overrides.window_background_opacity = theme.get_opacity(current)
        window:set_config_overrides(overrides)
    end
end

local function icon(process_name)
    return M.options.proc_icons[process_name] and M.options.proc_icons[process_name] .. ' '
        or M.options.proc_icons['default']
end

function M.format_tab_title(tab)
    local title_icon = icon(tab.active_pane.title)
    local title = ' ' .. tab.tab_index + 1 .. ': ' .. title_icon .. tab.active_pane.title .. ' '
    local first = tab.tab_index == 0

    local c = {
        fg = tab.is_active and colorscheme.foreground or colorscheme.background,
        bg = tab.is_active and colorscheme.background or colorscheme.foreground,
    }

    return not first
            and {
                { Foreground = { Color = colorscheme.background } },
                { Background = { Color = colorscheme.foreground } },
                { Text = ' ' },
                { Foreground = { Color = colorscheme.background } },
                { Background = { Color = colorscheme.foreground } },
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
end

-- TODO: extract common code in opacity_* font_size_* and line_height_*
function M.opacity_up(window, _)
    local overrides = window:get_config_overrides() or {}
    local current = overrides.window_background_opacity or M.options.opacity

    if current < 1 then
        overrides.window_background_opacity = current + 0.01
        window:set_config_overrides(overrides)
    end
end

function M.opacity_down(window, _)
    local overrides = window:get_config_overrides() or {}
    local current = overrides.window_background_opacity or M.options.opacity

    if current > 0.01 then
        overrides.window_background_opacity = current - 0.01
        window:set_config_overrides(overrides)
    end
end

function M.font_size_up(window, _)
    local overrides = window:get_config_overrides() or {}
    local current = overrides.font_size or font.options.size

    overrides.font_size = (current + 0.5)
    window:set_config_overrides(overrides)
end

function M.font_size_down(window, _)
    local overrides = window:get_config_overrides() or {}
    local current = overrides.font_size or font.options.size

    overrides.font_size = (current - 0.5)
    window:set_config_overrides(overrides)
end

function M.line_height_up(window, _)
    local overrides = window:get_config_overrides() or {}
    local current = overrides.line_height or font.options.line_height

    if current < 2 then
        overrides.line_height = (current + 0.05)
        window:set_config_overrides(overrides)
    end
end

function M.line_height_down(window, _)
    local overrides = window:get_config_overrides() or {}
    local current = overrides.line_height or font.options.line_height

    if current > 0 then
        overrides.line_height = (current - 0.05)
        window:set_config_overrides(overrides)
    end
end

function M.toggle_font(window, _)
    local overrides = window:get_config_overrides() or {}
    local current = not M.options.alt_font_active

    overrides.font_rules = font.get_rules(current)
    M.options.alt_font_active = current

    window:set_config_overrides(overrides)
end

function M.reset_font(window, _)
    local overrides = window:get_config_overrides() or {}

    M.options.alt_font_active = false

    overrides.font_size = font.get_scaled_size(window)

    window:set_config_overrides({
        font_size = overrides.font_size,
        colors = overrides.colors,
        window_background_opacity = overrides.window_background_opacity,
    })
end

function M.adapt_font_for_window_size(window, _)
    local overrides = window:get_config_overrides() or {}

    overrides.font_size = font.get_scaled_size(window)
    window:set_config_overrides(overrides)
end

function M.editor_mode(window, _)
    M.reset_font(window, _)

    local overrides = window:get_config_overrides() or {}
    local current = not M.options.editor_mode_active

    overrides.font_size = 19
    overrides.line_height = 2
    overrides.font_rules = font.get_rules(current)
    M.options.alt_font_active = current

    window:set_config_overrides(overrides)
end

function M.setup()
    wezterm.on('window-resized', M.adapt_font_for_window_size)

    local events = {
        ['editor-mode'] = M.editor_mode,
        ['font-size-down'] = M.font_size_down,
        ['font-size-up'] = M.font_size_up,
        ['format-tab-title'] = M.format_tab_title,
        ['line-height-down'] = M.line_height_down,
        ['line-height-up'] = M.line_height_up,
        ['opacity-down'] = M.opacity_down,
        ['opacity-up'] = M.opacity_up,
        ['reset-font'] = M.reset_font,
        ['toggle-font'] = M.toggle_font,
        ['window-config-reloaded'] = M.on_config_reloaded,
    }

    for event, handler in pairs(events) do
        wezterm.on(event, handler)
    end
end

return M
