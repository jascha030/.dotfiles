require('toggleterm').setup()

local Terminal = require('toggleterm.terminal').Terminal

local map = vim.keymap.set
local map_opts = { noremap = true, silent = true }

local lazygit = Terminal:new({
    cmd = 'lazygit',
    dir = 'git_dir',
    hidden = true,
    direction = 'float',
    float_opts = {
        border = 'rounded',
    },
})

local fpmlog = Terminal:new({
    cmd = 'fpmlog',
    direction = 'horizontal',
})

map('n', '<leader>l', function()
    fpmlog:toggle()
end, map_opts)

map('n', '<leader>g', function()
    lazygit:toggle()
end, map_opts)
