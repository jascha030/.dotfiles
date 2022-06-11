local wezterm = require('wezterm')

local function fb_font(name, args)
    return wezterm.font_with_fallback({ 'nonicons', name }, args)
end

local fonts = {
    default = wezterm.font('MesloLGS Nerd Font'),
    italic = wezterm.font('Dank Mono', { italic = true, weight = 500 }),
    normal = fb_font({ family = 'MesloLGS Nerd Font', italic = false, weight = 600 }),
}

return {
    size = 19,
    default = fonts.default,
    rules = {
        { italic = false, intensity = 'Normal', font = fonts.normal },
        { italic = true, intensity = 'Bold', font = fonts.normal },
        { italic = true, intensity = 'Normal', font = fonts.italic },
    },
}
