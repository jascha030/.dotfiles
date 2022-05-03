-- vim.api.nvim_set_keymap('n', 'CS', ':lua switcher()<CR>', { noremap = true })

local init = function()
    local colors = dofile(os.getenv('HOME') .. '/.config/wezterm/colors/jascha030/wez/og.lua').colors
    local colors_light = dofile(os.getenv('HOME') .. '/.config/wezterm/colors/jascha030/wez/og_light.lua').colors

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

    if vim.o.background == 'light' then
        vim.g.tokyonight_colors = vim.tbl_deep_extend('force', theme_colors, {})
        vim.g.tokyonight_style = 'day'
    else
        vim.g.tokyonight_colors = vim.tbl_deep_extend('force', theme_colors, {
            -- bg = colors.background,
            bg_dark = colors.background,
        })
        vim.g.tokyonight_style = 'storm'
    end

    vim.g.tokyonight_italic_functions = true
    vim.g.tokyonight_italic_comments = true
    vim.g.tokyonight_sidebars = { 'terminal', 'packer' }

    vim.cmd([[colorscheme tokyonight]])
end

local switcher = function()
    if vim.o.background == 'light' then
        vim.o.background = 'dark'
    else
        vim.o.background = 'light'
    end

    init()
end

return {
    switcher = switcher,
    init = init,
}
