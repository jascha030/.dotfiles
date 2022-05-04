local default_scheme = os.getenv('HOME') .. '/.config/wezterm/colors/jascha030/wez/og.lua'
local colors = dofile(default_scheme).colors

local theme_colors = {
    yellow = colors.yellow,
    red = colors.red,
    cyan = colors.cyan,
    magenta = '#bb9af7',
    purple = '#9d7cd8',
    orange = colors.red,
    green = colors.green,
    green1 = colors.cyan,
}

local color_overrides = {
    dark = { bg_dark = colors.background },
    light = {},
}

local set_background_timed = function()
    vim.o.background = tonumber(os.date('%H')) >= 19 and 'dark' or 'light'
end

local is_light = function()
    return vim.o.background == 'light'
end

local set_scheme_for_style = function()
    vim.g = vim.tbl_deep_extend('force', vim.g, {
        tokyonight_colors = vim.tbl_deep_extend(
            'force',
            theme_colors,
            is_light() and color_overrides.light or color_overrides.dark
        ),
        tokyonight_style = is_light() and 'day' or 'storm',
        tokyonight_italic_functions = true,
        tokyonight_italic_comments = true,
        tokyonight_sidebars = { 'terminal', 'packer' },
    })

    vim.cmd([[colorscheme tokyonight]])
end

local init = function(time_based)
    time_based = time_based or false

    if time_based == true then
        set_background_timed()
    end

    set_scheme_for_style()
end

local toggle = function()
    if is_light() then
        vim.o.background = 'dark'
    else
        vim.o.background = 'light'
    end

    init()
end

return {
    toggle = toggle,
    init = init,
}
