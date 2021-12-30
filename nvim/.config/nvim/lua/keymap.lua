local api = vim.api
local map = api.nvim_set_keymap;

-- Nvim Tree
map('n', '<C-n>', ':NvimTreeToggle<CR>', {noremap = true})
map('n', '<leader>f', ":lua require('plugins.telescope').project_files()<CR>", {noremap = true, silent = true})

-- Compe
map('i', '<C-Space>', [[ compe#complete() ]], {noremap = true, silent = true, expr = true})
map('i', '<CR>', [[ compe#confirm('<CR>') ]], {noremap = true, silent = true, expr = true})
map('i', '<C-e>', [[ compe#close('<C-e>') ]], {noremap = true, silent = true, expr = true})
map('i', '<C-f>', [[ compe#scroll({ 'delta': +4 }) ]], {noremap = true, silent = true, expr = true})
map('i', '<C-d>', [[ compe#scroll({ 'delta': -4 }) ]], {noremap = true, silent = true, expr = true})

