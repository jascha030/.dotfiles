local wezterm = require('wezterm')

local DEFAULT = 'Jetbrains Mono'

local defaults = {
    size = 16.3,
    line_height = 1.7,
    main = DEFAULT,
    alt = DEFAULT,
    italic = DEFAULT,
    fallback_font = 'Jetbrains Mono'
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
    local font = wezterm.font_with_fallback({
        'nonicons',
        'CaskaydiaCove Nerd Font',
        'PragmataPro Liga',
        'PragmataPro Mono Liga',
        'Noto Color Emoji',
        'JetBrains Mono',
        M.options.fallback_font,
    })

    return {
        { italic = false, intensity = 'Normal', font = font},
        { italic = true, intensity = 'Bold', font = font },
        { italic = true, intensity = 'Normal', font = font },
    }
end

M.setup()

return M
