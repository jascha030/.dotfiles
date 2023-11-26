-- stylua: ignore-start
--[[========================== Jascha030's =============================--
--   __  __  __  __  ______                __       __  __  ______      --
--  /\ \/\ \/\ \/\ \/\__  _\   /'\_/`\    /\ \     /\ \/\ \/\  _  \     --
--  \ \ `\\ \ \ \ \ \/_/\ \/  /\      \   \ \ \    \ \ \ \ \ \ \L\ \    --
--   \ \ , ` \ \ \ \ \ \ \ \  \ \ \__\ \   \ \ \  __\ \ \ \ \ \  __ \   --
--    \ \ \`\ \ \ \_/ \ \_\ \__\ \ \_/\ \   \ \ \L\ \\ \ \_\ \ \ \/\ \  --
--     \ \_\ \_\ `\___/ /\_____\\ \_\\ \_\   \ \____/ \ \_____\ \_\ \_\ --
--      \/_/\/_/`\/__/  \/_____/ \/_/ \/_/    \/___/   \/_____/\/_/\/_/ --
--[[================ beep-beep-Config-2.0-beep-boop ====================]]
-- stylua: ignore-end

BORDER = 'rounded'
BORDERS = { border = BORDER }

require('jascha030').setup({
    colorscheme = 'nitepal',
    polyglot = {
        enabled = true,
        languages = { 'zsh' },
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
            -- t_Co = '256',
        },
    },
    keymaps = {
        n = {
            ['t'] = { '<C-w>' },
            ['ff'] = { '<cmd>lua require("telescope.builtin").find_files()<cr>' },
            ['<C-p>'] = { '<cmd>lua require("telescope.builtin").git_files()<cr>' },
            ['fg'] = { '<cmd>lua require("telescope.builtin").live_grep()<cr>' },
            ['<C-f>'] = { '<cmd>lua require("telescope.builtin").current_buffer_fuzzy_find()<cr>' },
            ['<leader>hl'] = {
                '<cmd>lua require("telescope.builtin").highlights()<cr>',
                { desc = 'Show available highlights in ui.' },
            },
            ['<S-Tab>'] = {
                '<Plug>(cokeline-focus-next)',
                {
                    silent = true,
                },
            },
            ['<C-w><C-c>'] = { '<cmd>close<cr>' },
            ['<C-n>'] = { '<cmd>NeoTreeFocusToggle<cr>' },
            ['N'] = { '<cmd>NeoTreeFocus<cr>' },
            ['<C-t>'] = { '<cmd>Telescope<cr>' },
            ['<Tab><Tab>'] = { '<cmd>HopWord<cr>' },
            ['sR'] = {
                '<cmd>source $MYVIMRC<cr>',
                {
                    noremap = true,
                    silent = true,
                },
            },
            ['m'] = { '<cmd>Mason<cr>' },
            ['<C-/>'] = { '<cmd>CommentToggle<cr>' },
            ['<C-_>'] = { '<cmd>CommentToggle<cr>' },
            ['<leader>CP'] = { '<cmd>PickColor<cr>' },
            ['<leader>c'] = {
                '<cmd>lua require("jascha030.lsp.menu").show()<cr>',
                { desc = 'Context aware menu' },
            },
            ['<leader>tc'] = { '<cmd>lua vim.show_pos()<cr>' },
            ['<leader>p'] = { '<cmd>InspectTree<cr>' },
            ['<leader>l'] = { '<cmd>Lazy<cr>' },
        },
        v = {
            ['<C-c>'] = { ':OSCYankVisual<cr>' },
            ['<C-_>'] = { ":'<,'>CommentToggle<cr>" },
        },
        t = {
            ['<M-[>'] = { '<Esc>' },
            ['<C-v><Esc>'] = { '<Esc>' },
        },
        i = {},
    },
})
