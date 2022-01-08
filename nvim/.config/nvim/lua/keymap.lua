local api = vim.api
local map = api.nvim_set_keymap;

-- Nvim Tree
map('n', '<C-n>', ':NvimTreeToggle<CR>', {noremap = true})
map('n', '<leader>f', ":lua require('plugins.telescope').project_files()<CR>", {noremap = true, silent = true})


