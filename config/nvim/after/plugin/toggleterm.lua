require('toggleterm').setup()

local BORDER = { border = 'rounded' }
local Terminal = require('toggleterm.terminal').Terminal

local map = vim.keymap.set
local map_opts = { noremap = true, silent = true }

local lazygit = Terminal:new({
    cmd = 'lazygit',
    dir = 'git_dir',
    hidden = true,
    direction = 'float',
    float_opts = BORDER,
})

local fpmlog = Terminal:new({
    cmd = 'fpmlog',
    direction = 'horizontal',
})

local terminal = Terminal:new({
    cmd = '/usr/local/bin/zsh --login',
    dir = 'git_dir',
    hidden = true,
    direction = 'float',
    float_opts = BORDER,
})

local toggle_terminal = function()
    terminal:toggle()
end

local term_map = {
    ['n'] = { '<leader>t', '<C-t>' },
}

for k, v in pairs(term_map) do
    for _, keymap in pairs(v) do
        map(k, keymap, toggle_terminal, map_opts)
    end
end

function _G.set_terminal_keymaps()
    local opts = { buffer = 0 }
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', 'q', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd([[autocmd! TermOpen term://* lua set_terminal_keymaps()]])

map('n', '<leader>l', function()
    fpmlog:toggle()
end, map_opts)

map('n', '<leader>g', function()
    lazygit:toggle()
end, map_opts)
