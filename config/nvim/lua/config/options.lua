vim.opt.autoindent = true
vim.opt.autoread = true
vim.opt.undofile = true
vim.opt.backspace = 'indent,eol,start'
vim.opt.colorcolumn = '120'
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.fileencoding = 'utf-8'
vim.opt.gdefault = true
vim.opt.incsearch = true
vim.opt.modifiable = true
vim.opt.mouse = 'nvi'
vim.opt.number = true
vim.opt.rnu = true
vim.opt.scrolloff = 5
vim.opt.shiftwidth = 4
vim.opt.showtabline = 0
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.termguicolors = true
-- Keep the command-line height fixed at one line. Some plugins (e.g. noice with
-- messages enabled) set cmdheight=0, which makes the message/showmode area
-- temporarily expand by multiple lines whenever a message is printed -- exactly
-- what happens when toggling the snacks explorer while an opencode terminal
-- split is open on the right.
vim.opt.cmdheight = 1
-- Lualine already shows the mode, so hide the native -- INSERT -- / -- NORMAL --
-- messages to avoid extra command-line redraws.
vim.opt.showmode = false
vim.opt.updatetime = 1000
vim.opt.pumborder = 'rounded'
vim.opt.winborder = 'rounded'
vim.opt.fillchars = {
    eob = ' ',
    msgsep = '‾',
    horiz = '═',
    horizup = '╩',
    horizdown = '╦',
    vert = '║',
    vertleft = '╣',
    vertright = '╠',
    verthoriz = '╬',
}
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldmethod = 'expr'
vim.opt.shell = '/bin/zsh'
vim.opt.signcolumn = 'yes'
vim.opt.foldenable = false

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.gitblame_display_virtual_text = 0
vim.g.loaded_matchparen = 1
vim.g.editorconfig = 1
vim.g.loaded_python3_provider = 0
vim.g.loaded_python_provider = 0
