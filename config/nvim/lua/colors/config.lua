local M = {}

local color_map = {
    yellow = 'yellow',
    red = 'red',
    cyan = 'cyan',
    orange = 'red',
    green = 'green',
    green1 = 'cyan',
}

function M.get_default()
    return {
        scheme = 'jassie030',
        styles = {
            dark = 'storm',
            light = 'day',
        },
        overrides = {
            dark = color_map,
            light = color_map,
        },
        options = {
            tokyonight_sidebars = {
                'terminal',
                'packer',
                'nvim-tree',
            },
            tokyonight_transparent = true,
            tokyonight_italic_functions = true,
            tokyonight_italic_comments = true,
            tokyonight_transparent_sidebar = true,
            material_italic_comments = true,
            material_italic_keywords = true,
            material_italic_functions = true,
            material_italic_variables = false,
            material_contrast = false,
            material_borders = false,
        },
        colors = {
            dark = {},
            light = {},
        },
    }
end

function M.generate(config)
    config = config or {}

    local ok, scheme = pcall(require, 'colorschemes.' .. config.scheme)
    if not ok then
        error('Could not find colorscheme: "' .. config.scheme .. '".')
    end

    scheme = scheme.get_scheme()

    for style in pairs({ dark = config.overrides.dark, light = config.overrides.light }) do
        config.colors[style] = require('tokyonight.colors').setup({
            colors = {
                magenta = '#bb9af7',
                purple = '#9d7cd8',
            },
            style = config.styles[style],
        })

        for t_name, u_name in pairs(config.overrides[style]) do
            if not config.colors[style][t_name] then
                error('Invalid tokyonight color: "' .. t_name .. '".')
            end

            if not scheme[style][u_name] then
                error('Color "' .. u_name .. '" in user scheme "' .. config.scheme .. '".')
            end

            config.colors[style][t_name] = scheme[style][u_name]
        end
    end

    return config
end

function M.get_scheme(config)
    local ok, scheme = pcall(require, 'colorschemes.' .. config.scheme)

    if not ok then
        error('Could not find colorscheme: "' .. config.scheme .. '".')
    end

    return scheme
end

return M
