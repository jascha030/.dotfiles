local options_global = {
    mouse = 'a',
    termguicolors = true,
    incsearch = true,
    colorcolumn = '120',
    backspace = 'indent,eol,start',
    fileencoding = 'utf-8',
    fillchars = 'eob: ,msgsep:‾',
    scrolloff = 5,
    showtabline = 2,
    tabstop = 2,
    shiftwidth = 2,
    expandtab = true,
    smartindent = true,
    number = true,
    cursorline = true,
}

local options_buffer = {
}

local options_window = {
}

local options_vim_global = {
    mapleader = '<space>',
    material_italic_comments = true,
    material_italic_keywords = true,
    material_italic_functions = true,
    material_italic_variables = false,
    material_contrast = true,
    material_borders = true,
    material_style = 'palenight'
}


return {
    g = options_vim_global,
    o = options_global,
    b = options_buffer,
    w = options_window,
}
