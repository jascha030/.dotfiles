local api = vim.api
local map = api.nvim_set_keymap;

local opts =  {noremap = true}

-- Nvim Tree
map('n', '<C-n>', ':NvimTreeToggle<CR>', {noremap = true})
map('n', '<leader>f', ":lua require('plugins.telescope').project_files()<CR>", {noremap = true, silent = true})

--  Telescope
map('n', 'ss', ':Telescope<CR>', opts)
map('n', 'ff', ":lua require('telescope.builtin').find_files()<CR>", opts)
map('n', 'FF', ":lua require('telescope.builtin').file_browser()<CR>", opts)
map('n', 'fg', ":lua require('telescope.builtin').live_grep()<CR>", opts)

-- Lsp
map('n', '<C-l>', ":lua vim.lsp.buf.formatting()<CR>", opts)

-- Other
map('v', '<C-c>', ':OSCYank<CR>', opts)

-- Terminal
-- map('n', '<C-t>', ':terminal<CR>i', opts)
map('n', '<C-t>', ':FloatermToggle[!]<CR>', opts)
map('t', '<C-t>', '<C-\\><C-n> :FloatermToggle[!]<CR>', opts)
map('t', '<M-[>', '<Esc>', opts)
map('t', '<C-v><Esc>', '<Esc>', opts)

