-- Todo: make dynamic
local default = {
    dark = 'theme.jascha030.wez.og',
    light = 'theme.jascha030.wez.og_light',
}

local function scheme_from_colors(colors)
    return {
        background = colors.background,
        foreground = colors.foreground,

        cursor_bg = colors.yellow,
        cursor_fg = colors.background,

        ansi = {
            colors.black,
            colors.red,
            colors.green,
            colors.yellow,
            colors.blue,
            colors.magenta,
            colors.cyan,
            colors.white,
        },

        brights = {
            colors.bright_black,
            colors.bright_red,
            colors.bright_green,
            colors.bright_yellow,
            colors.bright_blue,
            colors.bright_magenta,
            colors.bright_cyan,
            colors.bright_white,
        },
    }
end

local function scheme_from_module(module, color_overrides)
    color_overrides = color_overrides or nil

    local ok, _ = pcall(require, module)
    if not ok then
        return
    end

    local scheme_colors = require(module)

    if color_overrides ~= nil then
        for k, v in pairs(color_overrides) do
            scheme_colors[k] = v
        end
    end

    return scheme_from_colors(scheme_colors)
end

local function is_dark(scheme)
    return scheme == 'Dark'
end

local function get_scheme(scheme)
    return scheme_from_module(is_dark(scheme) and default.dark or default.light)
end

return {
    scheme_from_colors = scheme_from_colors,
    scheme = scheme_from_module,
    get_scheme = get_scheme,
}
