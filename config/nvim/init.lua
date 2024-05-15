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

vim.loader.enable()
vim.g.maploader = ' '


local lazy_path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
local conf_path = vim.fn.stdpath('config') --[[@as string]]

if not vim.loop.fs_stat(lazy_path) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        '--single-branch',
        'https://github.com/folke/lazy.nvim.git',
        lazy_path,
    })
end

vim.opt.runtimepath:prepend(lazy_path)


require('jascha030').setup({
    env = {
        path = { vim.env.HOME .. '/.local/share/mise/shims' },
    },
    colorscheme = 'nitepal',
    polyglot = {
        enabled = false,
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
            -- fillchars = 'eob: ,msgsep:‾',
            fillchars = {
                eob = ' ',
                msgsep = '‾',
                horiz = '═',
                horizup = '╩',
                horizdown = '╦',
                vert = '║',
                vertleft = '╣',
                vertright = '╠',
                verthoriz = '╬',
            },
            signcolumn = 'yes',
            shell = '/bin/zsh',
            foldmethod = 'expr',
            foldexpr = 'nvim_treesitter#foldexpr()',
        },
        g = {
            loaded_netrw = 1,
            loaded_netrwPlugin = 1,
            gitblame_display_virtual_text = 0,
            loaded_matchparen = 1,
            editorconfig = 1,
            loaded_python3_provider = 0,
            loaded_python_provider = 0,
        },
        o = {
            foldenable = false,
        },
    },
    keymaps = {
        n = {
            ['t'] = { '<C-w>' },
            ['ff'] = { '<cmd>lua require("jascha030.utils.fs").file_picker()<cr>' },
            -- ['ff'] = { '<cmd>require("telescope.builtin").find_files()<cr>' },
            ['<C-p>'] = { '<cmd>lua require("telescope.builtin").git_files()<cr>' },
            ['fg'] = { '<cmd>lua require("telescope.builtin").live_grep()<cr>' },
            ['<C-f>'] = { '<cmd>lua require("telescope.builtin").current_buffer_fuzzy_find()<cr>' },
            ['<leader>hl'] = {
                '<cmd>lua require("telescope.builtin").highlights()<cr>',
                { desc = 'Show available highlights in ui.' },
            },
            ['<S-Tab>'] = {
                '<Plug>(cokeline-focus-next)',
                { silent = true },
            },
            ['<C-w><C-c>'] = { '<cmd>close<cr>' },
            ['<C-n>'] = { '<cmd>Neotree toggle focus<cr>' },
            ['N'] = { '<cmd>Neotree focus<cr>' },
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
            ['<leader>fh'] = { '<cmd>Telescope help_tags<cr>' },
            ['<leader>fc'] = { '<cmd>Telescope git_bcommits<cr>' },
            ['<leader>lz'] = { '<cmd>Lazy<cr>' },
            ['<leader>fs'] = { '<cmd>lua require("spectre").toggle()<CR>', { desc = 'Toggle Spectre' } },
            ['<leader>sw'] = {
                '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
                { desc = 'Search current word' },
            },
            ['<leader>sp'] = {
                '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
                { desc = 'Search on current file' },
            },
        },
        v = {
            ['<leader>sw'] = {
                '<esc><cmd>lua require("spectre").open_visual()<CR>',
                { desc = 'Search current word' },
            },
            ['<C-c>'] = { ':OSCYankVisual<cr>' },
            ['<C-_>'] = { ":'<,'>CommentToggle<cr>" },
        },
        t = {
            ['<M-[>'] = { '<Esc>' },
            ['<C-v><Esc>'] = { '<Esc>' },
        },
        i = {},
    },
    augroups = {
        _ft = {
            {
                event = 'FileType',
                pattern = { 'help', 'lspinfo', 'Trouble', 'dashboard' },
                command = 'nnoremap <buffer><silent> q :close<CR>',
            },
            {
                event = 'FileType',
                pattern = 'Trouble',
                command = 'nnoremap <buffer><silent> TT :close<CR>',
            },
        },
        open_folds = {
            {
                event = { 'BufReadPost', 'FileReadPost' },
                pattern = '*',
                command = 'normal zR',
            },
        },
        CmpSourceCargo = {
            {
                event = 'BufRead',
                pattern = 'Cargo.toml',
                callback = function()
                    require('cmp').setup.buffer({ sources = { { name = 'crates' } } })
                end,
            },
        },
    },
})


require('lazy').setup('jascha030.plugins', {
    concurrency = 5,
    performance = {
        rtp = {
            disabled_plugins = {
                'gzip',
                'matchit',
                'matchparen',
                'tarPlugin',
                'tohtml',
                'tutor',
            },
        },
    },
    ui = { border = BORDER },
})
