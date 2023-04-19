local M = {}

local wezterm = require('wezterm')
local font = require('fonts')

M.options = {
    opacity = 1,
    colors = {},
    alt_font_active = false,
}

function M.set_colors(colors)
    M.options.colors = colors
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
    M.options.alt_font_active = false
    window:set_config_overrides({})
end

function M.setup()
    local events = {
        ['opacity-up'] = M.opacity_up,
        ['opacity-down'] = M.opacity_down,
        ['font-size-up'] = M.font_size_up,
        ['font-size-down'] = M.font_size_down,
        ['line-height-up'] = M.line_height_up,
        ['line-height-down'] = M.line_height_down,
        ['toggle-font'] = M.toggle_font,
        ['reset-font'] = M.reset_font,
    }

    for event, handler in pairs(events) do
        wezterm.on(event, handler)
    end
end

return M
