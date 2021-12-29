-- Shortcuts for vim related functions
local cmd = vim.cmd  -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()
local scopes = require('utils.scopes')

local set_options = function(scope, options)
    for key, value  in pairs(options) do
        scope[key] = value
    end
end

-- Colors
cmd([[colorscheme tokyonight]])


-- Tabs (expandtab, smartindent defined in options_buffer)
local options_global = {
    mouse = 'a',
    showtabline = 2,
    scrolloff = 5,
    termguicolors = true,
    incsearch = true,
    colorcolumn = '120',
    backspace = 'indent,eol,start',
    tabstop = 4,
    shiftwidth = 4,
    fileencoding = 'utf-8',
	fillchars = 'eob: ,msgsep:‾'
}

local options_buffer = {
    expandtab = true,
    smartindent = true
}

local options_window = {
    number = true,
    cursorline = true,
}

local options_vim_global = {
	material_italic_comments = true,
	material_italic_keywords = true,
	material_italic_functions = true,
	material_italic_variables = false,
	material_contrast = true,
	material_borders = true,
	material_style = 'palenight'

}

set_options(scopes.o, options_global)
set_options(scopes.b, options_buffer)
set_options(scopes.w, options_window)
set_options(scopes.g, options_vim_global)
