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

local os_is_dark = function()
    return (vim.call('system', [[echo $(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo 'dark' || echo 'light')]])):find('dark') ~= nil
end

local is_dark = function()
    return vim.o.background == 'dark'
end

local set_scheme_for_style = function(dark)
    vim.g = vim.tbl_deep_extend('force', vim.g, {
        tokyonight_colors = vim.tbl_deep_extend(
            'force',
            theme_colors,
            dark and color_overrides.dark or color_overrides.light
        ),
        tokyonight_style = dark and 'storm' or 'day',
        tokyonight_italic_functions = true,
        tokyonight_italic_comments = true,
        tokyonight_sidebars = { 'terminal', 'packer' },
    })

    vim.cmd([[colorscheme tokyonight]])
end

local init = function()
    if os_is_dark() then
        vim.o.background = 'dark'
    else
        vim.o.background = 'light'
    end

    set_scheme_for_style(os_is_dark())
end

local toggle = function()
    if is_dark() then
        vim.o.background = 'light'
    else
        vim.o.background = 'dark'
    end

    set_scheme_for_style(is_dark())
end

return {
    toggle = toggle,
    init = init,
}
