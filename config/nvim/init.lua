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

-- Temporary fix: https://github.com/neovim/neovim/issues/31675
vim.hl = vim.highlight

if vim.loader then
    vim.loader.enable()
end

vim.g.mapleader = ' '

local lazy_path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
local lreq = require('jascha030.lreq')

_G.lreq = lreq

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

local lazy_opts = {
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
}

require('lazy').setup({
    -- Idea taken from `willothy/nvim-config` (https://github.com/willothy/nvim-config/blob/main/init.lua).
    {
        name = 'jascha030.init',
        main = 'jascha030',
        dir = vim.fn.stdpath('config') --[[@as string]],
        lazy = false,
        priority = 10000,
        ---@type jascha030.core.config.ConfigOptions
        opts = {
            debug = false,
            path = {
                env = {
                    vim.env.HOME .. '/.local/share/mise/shims',
                },
                rtp = {
                    {
                        path = '/Applications/Ghostty.app/Contents/Resources/vim/vimfiles',
                        prepend = true,
                    },
                },
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
                    autoindent = true,
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
            -- wip (field name: (identifier) @id (#match? @id "keymaps") value: (table_constructor (field value: (table_constructor) @t) @f))
            keymaps = {
                n = {
                    { 't', '<C-w>' },
                    { 'H', '<C-w>h', desc = 'navigate to the previous buffer' },
                    { 'L', '<C-w>l', desc = 'navigate to the next buffer' },
                    { 'ff', '<cmd>lua require("jascha030.utils.fs").file_picker()<cr>' },
                    { '<C-p>', '<cmd>lua require("telescope.builtin").git_files()<cr>' },
                    { 'fg', '<cmd>lua require("telescope.builtin").live_grep()<cr>' },
                    { '<C-f>', '<cmd>lua require("telescope.builtin").current_buffer_fuzzy_find()<cr>' },
                    { '<C-l>', "<cmd>lua require'conform'.format()<cr>", desc = 'Format using conform.' },
                    {
                        '<leader>hl',
                        '<cmd>lua require("telescope.builtin").highlights()<cr>',
                        desc = 'Show available highlights in ui.',
                    },
                    {
                        '<S-Tab>',
                        '<Plug>(cokeline-focus-next)',
                        opts = { silent = true },
                    },
                    { '<C-w><C-c>', '<cmd>close<cr>' },
                    { '<C-n>', '<cmd>Neotree toggle focus<cr>' },
                    { 'N', '<cmd>Neotree focus<cr>' },
                    { '<C-t>', '<cmd>Telescope<cr>' },
                    { '<leader><Tab><Tab>', '<cmd>HopWord<cr>' },
                    { '<leader>m', '<cmd>Mason<cr>' },
                    { '<C-_>', '<cmd>CommentToggle<cr>' },
                    { '<C-/>', '<cmd>CommentToggle<cr>' },
                    { '<leader>CP', '<cmd>PickColor<cr>' },
                    {
                        '<leader>c',
                        '<cmd>lua require("jascha030.lsp.menu").show()<cr>',
                        desc = 'Context aware menu',
                    },
                    { '<leader>e', '<cmd>e<cr>' },
                    { '<leader>p', '<cmd>InspectTree<cr>' },
                    { '<leader>pc', '<cmd>lua vim.show_pos()<cr>' },
                    { '<leader>fh', '<cmd>Telescope help_tags<cr>' },
                    { '<leader>fc', '<cmd>Telescope git_bcommits<cr>' },
                    { '<leader>lz', '<cmd>Lazy<cr>' },
                    { '<leader>fs', '<cmd>lua require("spectre").toggle()<CR>', desc = 'Toggle Spectre' },
                    {
                        '<leader>sw',
                        '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
                        desc = 'Search current word',
                    },
                    {
                        '<leader>sp',
                        '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
                        desc = 'Search on current file',
                    },
                },
                v = {
                    { '<C-c>', '"+y', desc = 'Yank to OS ClipBoard' },
                    {
                        '<leader>sw',
                        '<esc><cmd>lua require("spectre").open_visual()<CR>',
                        desc = 'Search current word',
                    },
                    { '<C-l>', "<cmd>lua require'conform'.format()<cr>", desc = 'Format using conform.' },
                    { '<C-_>', ":'<,'>CommentToggle<cr>" },
                    { '<C-/>', ":'<,'>CommentToggle<cr>" },
                },
                t = {},
                i = {},
            },
            augroups = {
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
        },
        config = function(_, opts)
            require('jascha030').setup(opts)
        end,
    },
    { import = 'jascha030.plugins' },
}, lazy_opts)
