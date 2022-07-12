--[[===========================Jascha030's==============================--
--                                                                      --
--   __  __  __  __  ______                __       __  __  ______      --
--  /\ \/\ \/\ \/\ \/\__  _\   /'\_/`\    /\ \     /\ \/\ \/\  _  \     --
--  \ \ `\\ \ \ \ \ \/_/\ \/  /\      \   \ \ \    \ \ \ \ \ \ \L\ \    --
--   \ \ , ` \ \ \ \ \ \ \ \  \ \ \__\ \   \ \ \  __\ \ \ \ \ \  __ \   --
--    \ \ \`\ \ \ \_/ \ \_\ \__\ \ \_/\ \   \ \ \L\ \\ \ \_\ \ \ \/\ \  --
--     \ \_\ \_\ `\___/ /\_____\\ \_\\ \_\   \ \____/ \ \_____\ \_\ \_\ --
--      \/_/\/_/`\/__/  \/_____/ \/_/ \/_/    \/___/   \/_____/\/_/\/_/ --
--                                                                      --
--                                                                      --
--[[==========================Configuration===========================]]

-- Options
require('options').setup({
    options = {
        mouse = 'a',
        termguicolors = true,
        incsearch = true,
        colorcolumn = '120',
        backspace = 'indent,eol,start',
        fileencoding = 'utf-8',
        fillchars = 'eob: ,msgsep:‾',
        scrolloff = 5,
        showtabline = 2,
        tabstop = 4,
        shiftwidth = 2,
        expandtab = true,
        smartindent = true,
        number = true,
        cursorline = true,
        modifiable = true,
        updatetime = 400,
        signcolumn = 'yes',
    },
    global = {
        mapleader = '<space>',
        material_italic_comments = true,
        material_italic_keywords = true,
        material_italic_functions = true,
        material_italic_variables = false,
        material_contrast = false,
        material_borders = false,
        material_style = 'tokyonight',
        node_host_prog = os.getenv('HOME') .. '/.fnm/node-versions/v17.7.1/installation/bin/neovim-node-host',
    },
})

-- Colorscheme overrides, uses color names as used by wezterm.
require('scheme').setup({
    overrides = {
        dark = {
            bg_dark = 'background',
            green = 'green',
            red = 'red',
            yellow = 'yellow',
        },
        light = {
            bg = 'background',
            bg_dark = 'background',
            blue = 'cyan',
            yellow = 'red',
            purple = 'bright_red',
            green1 = 'cyan',
            teal = 'red',
            green = 'green',
        },
    },
})

require('plugins')
require('lsp')
require('keymap')
