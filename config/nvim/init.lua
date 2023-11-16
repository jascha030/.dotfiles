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
    polyglot = {
        enabled = true,
        languages = {
            'zsh',
        },
    },
    opts = {
        opt = {
            termguicolors = true,
            expandtab = true,
            smartindent = true,
            number = true,
            cursorline = true,
            modifiable = true,
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
        o = {
            t_Co = '256',
        }
    },
    keymaps = {
        n = {
            ['ff'] = { '<CMD>lua require("telescope.builtin").find_files()<CR>' },
            ['<C-p>'] = { '<CMD>lua require("telescope.builtin").git_files()<CR>' },
            ['fg'] = { '<CMD>lua require("telescope.builtin").live_grep()<CR>' },
            ['<C-f>'] = { '<CMD>lua require("telescope.builtin").current_buffer_fuzzy_find()<CR>' },
            ['<leader><leader>h'] = { '<CMD>lua require("telescope.builtin").highlights()<CR>' },
            ['<S-Tab>'] = { '<Plug>(cokeline-focus-next)', { silent = true } },
            ['<C-w><C-c>'] = { '<CMD>close<CR>' },
            ['<C-n>'] = { '<CMD>NeoTreeFocusToggle<CR>' },
            ['N'] = { '<CMD>NeoTreeFocus<CR>' },
            ['<C-t>'] = { '<CMD>Telescope<CR>' },
            ['TT'] = { '<CMD>TroubleToggle<CR>' },
            ['<Tab><Tab>'] = { '<CMD>HopWord<CR>' },
            ['sR'] = { '<CMD>source $MYVIMRC<CR>', { noremap = true, silent = true } },
            ['m'] = { '<CMD>Mason<CR>' },
            ['<C-_>'] = { '<CMD>CommentToggle<CR>' },
            ['<leader>CP'] = { '<CMD>PickColor<CR>' },
            ['<leader>c'] = { '<CMD>lua require("jascha030.lsp.menu").show()<CR>', { desc = 'Context aware menu' } },
            ['<leader>tc'] = { '<CMD>lua vim.show_pos()<CR>' },
            ['<leader>p'] = { '<CMD>InspectTree<CR>' },
            ['<leader>l'] = { '<CMD>Lazy<CR>' },
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
