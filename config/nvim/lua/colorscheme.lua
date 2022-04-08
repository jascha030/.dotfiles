local colors = dofile(os.getenv('HOME') .. '/.config/wezterm/colors/jascha030/wez/og.lua').colors

vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_italic_comments = true
vim.g.tokyonight_sidebars = { 'terminal', 'packer' }

vim.g.tokyonight_colors = {
    -- bg = colors.background,
    bg_dark = colors.background,
    yellow = colors.yellow,
    red = colors.red,
    cyan = colors.cyan,
    magenta = '#bb9af7',
    magenta2 = '#ff007c',
    purple = '#9d7cd8',
    orange = '#ff9e64',
    green = colors.green,
    green1 = colors.cyan,
}

vim.cmd([[colorscheme tokyonight]])
