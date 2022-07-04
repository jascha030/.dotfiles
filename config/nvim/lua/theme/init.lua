require('theme.utils')

local scheme = require('theme.colors.jassie030')

local function colors()
    return DarkmodeEnabled() and scheme.dark or scheme.light
end

DOT_CUSTOM_COLORS = {
    yellow = colors().yellow,
    red = colors().red,
    cyan = colors().cyan,
    magenta = '#bb9af7',
    purple = '#9d7cd8',
    orange = colors().red,
    green = colors().green,
    green1 = colors().cyan,
}

DOT_CUSTOM_COLOR_OVERRIDES = {
    dark = {
        bg_dark = colors().background,
    },
    light = {
        blue = colors().blue,
        yellow = colors().red,
        purple = colors().bright_red,
        green1 = colors().cyan,
        green = colors().green,
    },
}

local tokyonight_colors = require('tokyonight').colors

local function merge_colors()
    return vim.tbl_deep_extend(
        'force',
        DOT_CUSTOM_COLORS,
        DarkmodeEnabled() and DOT_CUSTOM_COLOR_OVERRIDES.dark or DOT_CUSTOM_COLOR_OVERRIDES.light
    )
end

local function set_scheme_for_style(dark)
    vim.g = vim.tbl_deep_extend('force', vim.g, {
        tokyonight_colors = merge_colors(),
        tokyonight_style = dark and 'storm' or 'day',
        tokyonight_italic_functions = true,
        tokyonight_italic_comments = true,
        tokyonight_transparent_sidebar = true,
        tokyonight_transparent = true,
    })

    vim.cmd([[colorscheme tokyonight]])
end

local function set_from_os()
    vim.o.background = OSDarkmodeEnabled() and 'dark' or 'light'

    set_scheme_for_style(OSDarkmodeEnabled())
end

local function toggle()
    vim.o.background = DarkmodeEnabled() and 'light' or 'dark'

    set_scheme_for_style(DarkmodeEnabled())
end

local function init()
    set_from_os()

    vim.api.nvim_create_autocmd('Signal', {
        pattern = '*',
        callback = set_from_os,
    })
end

return {
    toggle = toggle,
    init = init,
}
