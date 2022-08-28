--[[===========================Jascha030's==============================--
--                                                                      --
--   __  __  __  __  ______                __       __  __  ______      --
--  /\ \/\ \/\ \/\ \/\__  _\   /'\_/`\    /\ \     /\ \/\ \/\  _  \     --
--  \ \ `\\ \ \ \ \ \/_/\ \/  /\      \   \ \ \    \ \ \ \ \ \ \L\ \    --
--   \ \ , ` \ \ \ \ \ \ \ \  \ \ \__\ \   \ \ \  __\ \ \ \ \ \  __ \   --
--    \ \ \`\ \ \ \_/ \ \_\ \__\ \ \_/\ \   \ \ \L\ \\ \ \_\ \ \ \/\ \  --
--     \ \_\ \_\ `\___/ /\_____\\ \_\\ \_\   \ \____/ \ \_____\ \_\ \_\ --
--      \/_/\/_/`\/__/  \/_____/ \/_/ \/_/    \/___/   \/_____/\/_/\/_/ --
--                                                                      --
--                                                                      --
--[[=================beep-beep-Config-2.0-beep-boop=====================]]

vim.o.runtimepath = vim.o.runtimepath .. ',' .. os.getenv('XDG_CONFIG_HOME')

local utils = require('utils')

vim.g.mapleader = [[ ]]

local options = {
    mouse = 'nvi',
    termguicolors = true,
    incsearch = true,
    colorcolumn = '120',
    backspace = 'indent,eol,start',
    fileencoding = 'utf-8',
    fillchars = 'eob: ,msgsep:‾',
    scrolloff = 5,
    showtabline = 2,
    tabstop = 4,
    shiftwidth = 4,
    expandtab = true,
    smartindent = true,
    number = true,
    cursorline = true,
    modifiable = true,
    updatetime = 400,
    signcolumn = 'yes',
}

local map = vim.api.nvim_set_keymap

local maps = {
            ['n'] = {
                ['ff'] = { ':lua require("telescope.builtin").find_files()<CR>' },
                ['FF'] = { ':lua require("telescope").extensions.file_browser.file_browser()<CR>' },
                ['fg'] = { ':lua require("telescope.builtin").live_grep()<CR>' },
                ['<C-f>'] = { ':lua require("telescope.builtin").current_buffer_fuzzy_find()<CR>' },
                ['<C-l>'] = { ':lua vim.lsp.buf.formatting()<CR>' },
                ['<S-Tab>'] = { '<Plug>(cokeline-focus-next)', { silent = true } },
                ['<C-w>'] = { '<cmd>close<CR>' },
                ['<C-n>'] = { '<cmd>NvimTreeToggle<CR>' },
                ['N'] = { '<cmd>NvimTreeFocus<CR>' },
                ['ss'] = { '<cmd>Telescope<CR>' },
                ['TT'] = { '<cmd>TroubleToggle<CR>' },
                ['<Tab><Tab>'] = { '<cmd>HopWord<CR>' },
                ['sR'] = { '<cmd>source $MYVIMRC<CR>', { noremap = true, silent = true } },
                ['<C-t>'] = { '<cmd>FloatermToggle[!]<CR>' },
                ['m'] = { '<cmd>Mason<CR>' },
                ['<C-_>'] = { '<cmd>CommentToggle<CR>' },
            },
            ['v'] = {
                ['<C-c>'] = { ':OSCYank<CR>' },
            },
            ['t'] = {
                ['<C-t>'] = { '<C-\\><C-n> :FloatermToggle[!]<CR>' },
                ['<M-[>'] = { '<Esc>' },
                ['<C-v><Esc>'] = { '<Esc>' },
            },
            ['i'] = {},
        }

local default_m_opts = { noremap = true }

for mtype, tmaps in pairs(maps) do
    for kmap, args in pairs(tmaps) do
        local a, o = args[1], args[2] or default_m_opts
        map(mtype, kmap, a, o)
    end
end

for k, v in pairs(options) do
	utils.opt(k, v)
end

require('lsp').init()
utils.plugin.create_cmds()

