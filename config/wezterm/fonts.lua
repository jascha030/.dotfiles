local wezterm = require('wezterm')
local DEFAULT = 'Jetbrains Mono'

local defaults = {
    size = 16.3,
    line_height = 1.6,
    main = DEFAULT,
    alt = DEFAULT,
    italic = DEFAULT,
    fallback_font = {
        family = 'Jetbrains Mono',
        italic = false,
        weight = 600,
    },
}

local M = { options = {} }

local function table_merge(t1, t2)
    for k, v in pairs(t2) do
        if type(v) == 'table' then
            if type(t1[k] or false) == 'table' then
                M.table_merge(t1[k] or {}, t2[k] or {})
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

function M.fallback_font(main, alt)
    main = main or M.options.main
    alt = alt or M.options.alt

    return wezterm.font_with_fallback({
        'nonicons',
        { family = main, italic = false, weight = 600 },
        { family = alt, italic = false, weight = 600 },
        M.options.fallback_font,
    })
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

function M.get_rules(alt)
    local font = M.fallback_font()

    if alt == true then
        font = M.fallback_font('Dank Mono', 'Dank Mono')
    end

    return {
        { italic = false, intensity = 'Normal', font = font },
        { italic = true, intensity = 'Bold', font = font },
        { italic = true, intensity = 'Normal', font = wezterm.font(M.options.italic, { italic = true }) },
    }
end

M.setup()

return M
