--[[
-- Alternative [b]ackgrounds/[f]oregrounds
    [b] "#e7e9ef",
    [b] "#D8DEE9",
    [b] '#DFE1E8',
    [b] '#c9c9e9',
    [b] "#f0e9e9",
    [f] "#444a73",
    [f] '#40456D',
--]]
local M = {
    colors = {
        black = '#32466e',
        red = '#ea1479',
        green = '#2da44e',
        yellow = '#ffcc00',
        blue = '#3d59a1',
        magenta = '#6f42c1',
        cyan = '#0a6e81',
        white = '#969ac9',

        bright_black = '#465a82',
        bright_red = '#f47cb4',
        bright_green = '#9ece6a',
        bright_yellow = '#ffae31',
        bright_blue = '#8494FF',
        bright_magenta = '#bb9af7',
        bright_cyan = '#1abc9c',
        bright_white = '#fffcfc',

        alt_black = '#32466e',
        alt_red = '#ff007c',
        alt_green = '#8fd742',
        alt_yellow = '#ff8000',
        alt_blue = '#0083f7',
        alt_magenta = '#5f5fec',
        alt_white = '#6183bb',

        none = 'NONE',

        additional = {
            git_orange = '#f05033',
        },
    },
    variants = {
        light = {
            background = '#e7e9ee',
            foreground = '#40456d',
        },
        dark = {
            background = '#1e2030',
            foreground = '#c8d3f5',
        },
    },
}

function M.merge_colors(types, shared)
    local scheme = {}

    for type, values in pairs(types) do
        for c, v in pairs(shared) do
            values[c] = v
        end
        scheme[type] = values
    end

    return scheme
end

function M.get_scheme()
    return M.merge_colors(M.variants, M.colors)
end

return M
