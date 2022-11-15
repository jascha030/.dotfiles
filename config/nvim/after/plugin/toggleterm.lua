require('toggleterm').setup()

local M = {}

local BORDER = { border = 'rounded' }
local MAP_OPTS = { noremap = true, silent = true }

local fpmlog, terminal, lazygit = nil, nil, nil

local map = vim.keymap.set
local Terminal = require('toggleterm.terminal').Terminal

function M.get_terminal()
    if terminal == nil then
        terminal = Terminal:new({
            cmd = '/usr/local/bin/zsh --login',
            dir = 'git_dir',
            hidden = true,
            direction = 'float',
            float_opts = BORDER,
        })
    end

    return terminal
end

function M.get_lazygit()
    if lazygit == nil then
        lazygit = Terminal:new({
            cmd = 'lazygit',
            dir = 'git_dir',
            hidden = true,
            direction = 'float',
            float_opts = BORDER,
        })
    end

    return lazygit
end

function M.get_fpmlog()
    if fpmlog == nil then
        fpmlog = Terminal:new({ cmd = 'fpmlog', direction = 'horizontal' })
    end

    return fpmlog
end

local toggle_terminal = function()
    M.get_terminal():toggle()
end

local toggle_fpmlog = function()
    M.get_fpmlog():toggle()
end

local toggle_lazygit = function()
    M.get_lazygit():toggle()
end

function _G.set_terminal_keymaps()
    local opts = { noremap = true, buffer = 0 }

    map('t', '<esc><esc>', [[<C-\><C-n>]], opts)
    map('t', '<C-w>', [[:close<CR>]], opts)
    map('n', 'q', [[:close<CR>]], opts)
end

vim.cmd([[autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()]])

map('n', '<leader>t', toggle_terminal, MAP_OPTS)
-- map('n', '<C-t>', toggle_terminal, MAP_OPTS)
map('n', '<leader>l', toggle_fpmlog, MAP_OPTS)
map('n', '<leader>g', toggle_lazygit, MAP_OPTS)
