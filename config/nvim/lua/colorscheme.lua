local default_scheme = os.getenv('HOME') .. '/.config/wezterm/theme/jascha030/wez/og.lua'
local colors = dofile(default_scheme)

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

local function os_is_dark()
    local cmd = [[echo $(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo 'dark' || echo 'light')]]

    return (vim.call('system', cmd)):find('dark') ~= nil
end

local is_dark = function()
    return vim.o.background == 'dark'
end

local function set_scheme_for_style(dark)
    local overrides = dark and color_overrides.dark or color_overrides.light

    vim.g = vim.tbl_deep_extend('force', vim.g, {
        tokyonight_colors = vim.tbl_deep_extend('force', theme_colors, overrides),
        tokyonight_style = dark and 'storm' or 'day',
        tokyonight_italic_functions = true,
        tokyonight_italic_comments = true,
        tokyonight_transparent_sidebar = true,
        tokyonight_transparent = true,
    })

    vim.cmd([[colorscheme tokyonight]])
end

local set_from_os = function()
    vim.o.background = os_is_dark() and 'dark' or 'light'

    set_scheme_for_style(os_is_dark())
end

local init = function()
    set_from_os()

    vim.api.nvim_create_autocmd('Signal', {
        pattern = '*',
        callback = function()
            set_from_os()
        end,
    })
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
