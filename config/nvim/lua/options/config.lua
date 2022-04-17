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
    modifiable = true,
    updatetime = 400,
}

local options_buffer = {}

local options_window = {}

local options_vim_global = {
    mapleader = '<space>',
    material_italic_comments = true,
    material_italic_keywords = true,
    material_italic_functions = true,
    material_italic_variables = false,
    material_contrast = true,
    material_borders = true,
    material_style = 'palenight',
    node_host_prog = os.getenv('HOME') .. '/.fnm/node-versions/v17.7.1/installation/bin/neovim-node-host',
}

return {
    g = options_vim_global,
    o = options_global,
    b = options_buffer,
    w = options_window,
}
