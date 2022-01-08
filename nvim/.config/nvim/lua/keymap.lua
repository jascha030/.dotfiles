local api = vim.api
local map = api.nvim_set_keymap;

-- Nvim Tree
map('n', '<C-n>', ':NvimTreeToggle<CR>', {noremap = true})
map('n', '<leader>f', ":lua require('plugins.telescope').project_files()<CR>", {noremap = true, silent = true})

--  Telescope
map('n', 'ss', ':Telescope<CR>', {noremap = true})
map('n', 'ff', ":lua require('telescope.builtin').find_files()<CR>", {noremap = true})
map('n', 'FF', ":lua require('telescope.builtin').file_browser()<CR>", {noremap = true})
map('n', 'fg', ":lua require('telescope.builtin').live_grep()<CR>", {noremap = true})

-- Lsp
map('n', '<C-l>', ":lua vim.lsp.buf.formatting()<CR>", {noremap = true})

