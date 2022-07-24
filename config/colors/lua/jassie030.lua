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

local old_colors = {
    red = '#ea1479',
    green = '#9ece6a',
    yellow = '#ffcc00',
    blue = '#0083f7',
    magenta = '#6f42c1',
    cyan = '#8494FF',
    white = '#737aa2',

    bright_black = '#969ac9',
    bright_red = '#f47cb4',
    bright_green = '#d4eb70',
    bright_yellow = '#e7c547',
    bright_blue = '#6183bb',
    bright_cyan = '#1abc9c',
    bright_magenta = '#bb9af7',
}

local colors = {
    red = '#ea1479',
    green = '#2da44e',
    yellow = '#ffcc00',
    blue = '#3d59a1',
    magenta = '#6f42c1',
    cyan = '#0a6e81',

    bright_red = '#f47cb4',
    bright_green = '#9ece6a',
    bright_yellow = '#ffae31',
    bright_blue = '#8494FF',
    bright_magenta = '#bb9af7',
    bright_cyan = '#1abc9c',
    
    black = '#32466e',
    bright_black = '#465a82',


    white = '#a9b1d6',
    bright_white = '#fffcfc',
}

local variants = {
    light = {
        background = '#e9e9ec',
        foreground = '#444a73',
    },
    dark = {
        background = '#1e2030',
        foreground = '#c8d3f5',
    },
}

local colors_l = {
    bg = '#e9e9ec',
    bg_dark = '#e9e9ec',
    bg_float = '#1a1b26',
    bg_highlight = '#292e42',
    bg_popup = '#16161e',
    bg_search = '#3d59a1',
    bg_sidebar = '#1a1b26',
    bg_statusline = '#16161e',
    bg_visual = '#33467C',
    black = '#15161E',
    blue = '#8494FF',
    blue0 = '#3d59a1',
    blue1 = '#2ac3de',
    blue2 = '#0db9d7',
    blue5 = '#89ddff',
    blue6 = '#B4F9F8',
    blue7 = '#394b70',
    border = '#15161E',
    border_highlight = '#3d59a1',
    comment = '#565f89',
    cyan = '#8494FF',
    dark3 = '#545c7e',
    dark5 = '#737aa2',
    diff = {
        add = '#20303B',
        change = '#1F2231',
        delete = '#37222C',
        text = '#394b70',
    },
    error = '#db4b4b',
    fg = '#c0caf5',
    fg_gutter = '#3b4261',
    fg_sidebar = '#a9b1d6',
    git = {
        add = '#449dab',
        change = '#6183bb',
        conflict = '#bb7a61',
        delete = '#914c54',
        ignore = '#545c7e',
    },
    gitSigns = {
        add = '#266d6a',
        change = '#536c9e',
        delete = '#b2555b',
    },
    green = '#9ece6a',
    green1 = '#8494FF',
    green2 = '#41a6b5',
    hint = '#1abc9c',
    info = '#0db9d7',
    magenta = '#bb9af7',
    magenta2 = '#ff007c',
    orange = '#ea1479',
    red = '#ea1479',
    red1 = '#db4b4b',
    terminal_black = '#414868',
    warning = '#e0af68',
    yellow = '#ea1479',
}

-- Old/unused colors
-- '#f47cb4',
-- '#ff007c',
-- '#1a1423'
-- '#1e2030'
-- '#1f2335'
-- '#252d53'
-- '#3b4261'
-- '#444a73'
-- '#555b86'
-- '#626793'
-- '#545c7e'
-- '#6183bb'
-- '#e9e9e9',
-- '#53ba0e',
-- '#8fd742',
-- '#37ae31',
-- '#2fc328',
-- '#398c57',
-- '#ff8000',
-- '#db4b4b',
-- '#6183bb',
-- '#ad541c',
-- '#1abc9c'
-- '#cdffb0'
-- '#d4eb70'
-- '#c5c8c6'
-- '#f0f0ff'
-- '#c099ff'
-- '#a395cf'
-- '#7fefef'
-- '#1e2030',
-- '#c8d3f5',
-- '#444a73',
-- '#fffcfc',


return merge_colors(variants, colors)
