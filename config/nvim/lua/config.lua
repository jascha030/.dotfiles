local M = {}

M.config = {
    colors = {
        overrides = {
            dark = {
                bg_dark = 'background',
                green = 'bright_green',
                red = 'red',
                yellow = 'yellow',
                green1 = 'bright_blue',
                teal = 'red',
                cyan = 'bright_blue',
            },
            light = {
                bg = 'background',
                bg_dark = 'background',
                yellow = 'red',
                purple = 'bright_red',
                magenta = 'bright_magenta',
                green = 'bright_green',
                green1 = 'bright_blue',
                blue = 'bright_blue',
                teal = 'bright_red',
                bg_sidebar = 'none',
            },
        },
    },
    options = {
        options = {
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
        },
        global = {
            mapleader = [[ ]],
            material_style = 'tokyonight',
            node_host_prog = os.getenv('HOME') .. '/.fnm/node-versions/v17.7.1/installation/bin/neovim-node-host',
        },
    },
    keymaps = {
        maps = {
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
        },
    },
}

M.scheme = M.config.colors

function M.get_config()
    return pairs(M.config)
end

return M
