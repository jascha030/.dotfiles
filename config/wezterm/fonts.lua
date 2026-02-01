local wezterm = require('wezterm')

local DEFAULT = 'Jetbrains Mono'

local defaults = {
    -- size = 16.3,
    size = 14.5,
    line_height = 1.7,
    main = nil,
    bold = nil,
    italic = nil,
    font_list = { DEFAULT },
}

---@class WezFontConfig
local M = { options = {} }

local function table_merge(t1, t2)
    for k, v in pairs(t2) do
        if type(v) == 'table' then
            if type(t1[k] or false) == 'table' then
                table_merge(t1[k] or {}, t2[k] or {})
            else
                t1[k] = v
            end
        else
            t1[k] = v
        end
    end
    return t1
end

function M.setup(options)
    M.options = table_merge(defaults, options or {})
end

function M.extend(options)
    M.options = table_merge(M.options or defaults, options or {})
end

function M.should_show_full_scale(window)
    local dimensions = window:get_dimensions()
    local is_lg_dpi = window:get_dimensions().dpi > 100

    local height = is_lg_dpi and 1000 or 1000
    local width = is_lg_dpi and 3000 or 1700

    return dimensions.pixel_height > height or dimensions.pixel_width > width
end

function M.get_scaled_size(window)
    return M.should_show_full_scale(window) and M.options.size or (M.options.size - 2)
end

function M.get_rules()
    local font = wezterm.font_with_fallback(M.options.font_list)

    local normal = font
    local bold = font
    local italic = font

    if M.options.main ~= nil then
        normal = M.options.main
    end

    if M.options.bold ~= nil then
        bold = M.options.bold
    end

    if M.options.italic ~= nil then
        italic = M.options.italic
    end

    return {
        { italic = false, intensity = 'Normal', font = normal },
        { italic = true, intensity = 'Bold', font = bold },
        { italic = true, intensity = 'Normal', font = italic },
        { italic = true, intensity = 'Bold', font = italic },
    }
end

function M.extend_config(config)
    config.font = wezterm.font_with_fallback(M.options.font_list)
    config.font_size = M.options.size
    config.line_height = M.options.line_height

    return config
end

M.setup()

return M
