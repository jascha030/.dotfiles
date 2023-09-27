--[[========================== Jascha030's =============================--
--   __  __  __  __  ______                __       __  __  ______      --
--  /\ \/\ \/\ \/\ \/\__  _\   /'\_/`\    /\ \     /\ \/\ \/\  _  \     --
--  \ \ `\\ \ \ \ \ \/_/\ \/  /\      \   \ \ \    \ \ \ \ \ \ \L\ \    --
--   \ \ , ` \ \ \ \ \ \ \ \  \ \ \__\ \   \ \ \  __\ \ \ \ \ \  __ \   --
--    \ \ \`\ \ \ \_/ \ \_\ \__\ \ \_/\ \   \ \ \L\ \\ \ \_\ \ \ \/\ \  --
--     \ \_\ \_\ `\___/ /\_____\\ \_\\ \_\   \ \____/ \ \_____\ \_\ \_\ --
--      \/_/\/_/`\/__/  \/_____/ \/_/ \/_/    \/___/   \/_____/\/_/\/_/ --
--[[================ beep-beep-Config-2.0-beep-boop ====================]]

BORDER = 'rounded'
BORDERS = { border = BORDER }

require('jascha030').setup({
    colorscheme = 'nitepal',
    opts = {
        opt = {
            expandtab = true,
            smartindent = true,
            number = true,
            cursorline = true,
            modifiable = true,
            termguicolors = true,
            incsearch = true,
            rnu = true,
            scrolloff = 5,
            showtabline = 2,
            tabstop = 4,
            shiftwidth = 4,
            updatetime = 1000,
            mouse = 'nvi',
            colorcolumn = '120',
            backspace = 'indent,eol,start',
            fileencoding = 'utf-8',
            fillchars = 'eob: ,msgsep:‾',
            signcolumn = 'yes',
            shell = '/bin/zsh',
            foldmethod = 'expr',
            foldexpr = 'nvim_treesitter#foldexpr()',
        },
        g = {
            loaded_netrw = 1,
            loaded_netrwPlugin = 1,
            gitblame_display_virtual_text = 0,
            editorconfig = true,
        },
    },
    keymaps = {
        n = {
            ['ff'] = { ':lua require("telescope.builtin").find_files()<CR>' },
            ['<C-p>'] = { ':lua require("telescope.builtin").git_files()<CR>' },
            ['fg'] = { ':lua require("telescope.builtin").live_grep()<CR>' },
            ['<C-f>'] = { ':lua require("telescope.builtin").current_buffer_fuzzy_find()<CR>' },
            ['<leader><leader>h'] = { ':lua require("telescope.builtin").highlights()<CR>' },
            ['<S-Tab>'] = { '<Plug>(cokeline-focus-next)', { silent = true } },
            ['<C-w><C-c>'] = { '<cmd>close<CR>' },
            ['<C-n>'] = { '<cmd>NeoTreeFocusToggle<CR>' },
            ['N'] = { '<cmd>NeoTreeFocus<CR>' },
            ['ss'] = { '<cmd>Telescope<CR>' },
            ['TT'] = { '<cmd>TroubleToggle<CR>' },
            ['<Tab><Tab>'] = { '<cmd>HopWord<CR>' },
            ['sR'] = { '<cmd>source $MYVIMRC<CR>', { noremap = true, silent = true } },
            ['<C-t>'] = { '<cmd>[!]<CR>' },
            ['m'] = { '<cmd>Mason<CR>' },
            ['<C-_>'] = { '<cmd>CommentToggle<CR>' },
            ['<leader>CP'] = { '<cmd>PickColor<CR>' },
            -- TreeSitter
            ['<leader>tc'] = { ':lua vim.show_pos()<CR>' },
            ['<leader>p'] = { '<cmd>InsprectTree<CR>' },
            ['<leader>l'] = { '<cmd>Lazy<CR>' },
        },
        v = {
            ['<C-c>'] = { ':OSCYankVisual<CR>' },
            ['<C-_>'] = { ":'<,'>CommentToggle<CR>" },
        },
        t = {
            ['<M-[>'] = { '<Esc>' },
            ['<C-v><Esc>'] = { '<Esc>' },
        },
        i = {},
    },
})

