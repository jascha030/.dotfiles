local M = {}

local wezterm = require('wezterm')
local theme = require('theme')
local font = require('fonts')

M.options = {
    opacity = 1,
    colors = theme.get_scheme('Dark', true),
    alt_font_active = false,
}

local proc_icons = {
    ['default'] = ' ',
    ['nvim'] = ' ',
}

local function icon(process_name)
    return proc_icons[process_name] and proc_icons[process_name] .. ' ' or proc_icons['default']
end

function M.window_config_reloaded(window)
    local current = window:get_appearance()
    local overrides = window:get_config_overrides() or {}

    M.options.colors = theme.get_scheme(current, true)

    if overrides.colors ~= M.options.colors then
        overrides.colors = M.options.colors
        window:set_config_overrides(overrides)
    end
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

    if current > 0 then
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
    M.options.alt_font_active = false
    window:set_config_overrides({})
end

function M.format_tab_title(tab)
    local title_icon = icon(tab.active_pane.title)
    local title = ' ' .. tab.tab_index + 1 .. ': ' .. title_icon .. tab.active_pane.title .. ' '
    local first = tab.tab_index == 0

    local c = {
        fg = tab.is_active and M.options.colors.foreground or M.options.colors.background,
        bg = tab.is_active and M.colors.background or M.colors.foreground,
    }

    return not first
            and {
                { Foreground = { Color = M.options.colors.background } },
                { Background = { Color = M.options.colors.foreground } },
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
end

function M.setup()
    local events = {
        ['window-config-reloaded'] = M.window_config_reloaded,
        ['opacity-up'] = M.opacity_up,
        ['opacity-down'] = M.opacity_down,
        ['font-size-up'] = M.font_size_up,
        ['font-size-down'] = M.font_size_down,
        ['line-height-up'] = M.line_height_up,
        ['line-height-down'] = M.line_height_down,
        ['toggle-font'] = M.toggle_font,
        ['format-tab-title'] = M.format_tab_title,
        ['reset-font'] = M.reset_font,
    }

    for event, handler in pairs(events) do
        wezterm.on(event, handler)
    end
end

return M
