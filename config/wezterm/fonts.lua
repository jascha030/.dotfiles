local wezterm = require('wezterm')

local M = {}

M.default_size = 19

function M.fallback_font(main, alt)
    return wezterm.font_with_fallback({
        'nonicons',
        { family = main, italic = false, weight = 600 },
        { family = alt, italic = false, weight = 600 },
        { family = 'Jetbrains Mono', italic = false, weight = 500 },
    })
end

function M.get(main, alt, size)
    size = size or M.default_size

    return {
        size = size,
        default = wezterm.font(main),
        rules = {
            { italic = false, intensity = 'Normal', font = M.fallback_font(main, alt) },
            { italic = true, intensity = 'Bold', font = M.fallback_font(main, alt) },
            { italic = true, intensity = 'Normal', font = wezterm.font('Dank Mono', { italic = true, weight = 500 }) },
        },
    }
end

return M
