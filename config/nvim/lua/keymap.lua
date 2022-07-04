local kmap = require('util').kmap
local default_opts = { noremap = true }

local function map(keymap, action, opts)
    kmap(keymap, action, 'n', opts or default_opts)
end
local function vmap(keymap, action, opts)
    kmap(keymap, action, 'v', opts or default_opts)
end
local function tmap(keymap, action, opts)
    kmap(keymap, action, 't', opts or default_opts)
end

-- Cokeline
map('<S-Tab>', '<Plug>(cokeline-focus-next)', { silent = true })
map('<C-w>', ':close<CR>')

-- Nvim Tree
map('<C-n>', ':NvimTreeToggle<CR>', { noremap = true })
map('<leader>f', ':lua require("plugins.telescope").project_files()<CR>', { noremap = true, silent = true })
map('N', ':NvimTreeFocus<CR>', { noremap = true })

--  Telescope
map('ss', ':Telescope<CR>')
map('ff', ':lua require("telescope.builtin").find_files()<CR>')
map('FF', ':lua require("telescope").extensions.file_browser.file_browser()<CR>')
map('fg', ':lua require("telescope.builtin").live_grep()<CR>')
map('<C-f>', ':lua require("telescope.builtin").current_buffer_fuzzy_find()<CR>')

-- Lsp
map('<C-l>', ':lua vim.lsp.buf.formatting()<CR>')

-- Other
vmap('<C-c>', ':OSCYank<CR>')

-- Terminal
map('<C-t>', ':FloatermToggle[!]<CR>')

tmap('<C-t>', '<C-\\><C-n> :FloatermToggle[!]<CR>')
tmap('<M-[>', '<Esc>')
tmap('<C-v><Esc>', '<Esc>')

-- Hop hop, keymappie erop
map('<Tab><Tab>', ':HopWord<CR>')
map('sR', ':source $MYVIMRC<CR>', { noremap = true, silent = true })

-- Switch between light/dark mode.
map('CS', ':lua require("theme").toggle()<CR>')

-- Other
vmap('<C-c>', ':OSCYank<CR>')
