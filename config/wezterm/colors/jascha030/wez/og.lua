local colors = {
    background = '#212431',
    foreground = '#a6accd',

    black = '#1a1423',
    red = '#ea1479',
    green = '#d4eb70',
    yellow = '#ffcc00',
    blue = '#0083f7',
    magenta = '#6f42c1',
    cyan = '#8494FF',
    white = '#c5c8c6',

    bright_black = '#666666',
    bright_red = '#F47CB4',
    bright_green = '#cdffb0',
    bright_yellow = '#e7c547',
    bright_blue = '#c397d8',
    bright_magenta = '#7fefef',
    bright_cyan = '#a395cf',
    bright_white = '#fefefe',
}

local scheme = {
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

return {
  colors = colors,
  scheme = scheme
}
