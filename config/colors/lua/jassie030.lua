-- Old/unused colors
-- '#1f2335'
-- '#252d53'
-- '#3b4261'
-- '#444a73'
-- '#555b86'
-- '#626793'
-- '#545c7e'
-- '#1e2030'
-- '#6183bb'
-- '#1abc9c'
-- '#cdffb0'
-- '#a395cf'
-- '#d4eb70'
-- '#1a1423'
-- '#c5c8c6'
-- '#c099ff'
-- '#a395cf'
-- '#7fefef'

local function merge_colors(types, shared)
    local scheme = {}

    for type, values in pairs(types) do
        for c, v in pairs(shared) do
            values[c] = v
        end
        scheme[type] = values
    end

    return scheme
end

local colors = {
    red =            '#ea1479',
    green =          '#9ece6a',
    yellow =         '#ffcc00',
    blue =           '#0083f7',
    magenta =        '#6f42c1',
    cyan =           '#8494FF',
    white =          '#737aa2',

    bright_black =   '#969ac9',
    bright_red =     '#f47cb4',
    bright_green =   '#d4eb70',
    bright_yellow =  '#e7c547',
    bright_blue =    '#6183bb',
    bright_cyan =    '#1abc9c',
    bright_magenta = '#bb9af7',
    bright_white =   '#f0f0ff',
}

local variants = {
    light = {
        background = '#c8d3f5',
        foreground = '#444a73',
        black =      '#1e2030',
    },
    dark = {
        background = '#1e2030',
        foreground = '#c8d3f5',
        black =      '#444a73',
    },
}

return merge_colors(variants, colors)
