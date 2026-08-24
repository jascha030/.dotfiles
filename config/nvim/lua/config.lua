local M = {}

function M.setup()
    vim.opt.autoindent = true
    vim.opt.autoread = true
    vim.opt.undofile = true
    vim.opt.backspace = 'indent,eol,start'
    vim.opt.colorcolumn = '120'
    vim.opt.cursorline = true
    vim.opt.expandtab = true
    vim.opt.fileencoding = 'utf-8'
    vim.opt.gdefault = true
    vim.opt.incsearch = true
    vim.opt.modifiable = true
    vim.opt.mouse = 'nvi'
    vim.opt.number = true
    vim.opt.rnu = true
    vim.opt.scrolloff = 5
    vim.opt.shiftwidth = 4
    vim.opt.showtabline = 0
    vim.opt.smartindent = true
    vim.opt.tabstop = 4
    vim.opt.termguicolors = true
    vim.opt.updatetime = 1000
    vim.opt.pumborder = 'rounded'
    vim.opt.winborder = 'rounded'
    vim.opt.fillchars = {
        eob = ' ',
        msgsep = '‾',
        horiz = '═',
        horizup = '╩',
        horizdown = '╦',
        vert = '║',
        vertleft = '╣',
        vertright = '╠',
        verthoriz = '╬',
    }
    vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
    vim.opt.foldmethod = 'expr'
    vim.opt.shell = '/bin/zsh'
    vim.opt.signcolumn = 'yes'
    vim.opt.foldenable = false

    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.g.gitblame_display_virtual_text = 0
    vim.g.loaded_matchparen = 1
    vim.g.editorconfig = 1
    vim.g.loaded_python3_provider = 0
    vim.g.loaded_python_provider = 0

    vim.keymap.set('n', '[b', '<cmd>bprevious<cr>', { desc = 'Cycle to previous buffer' })
    vim.keymap.set('n', ']b', '<cmd>bnext<cr>', { desc = 'Cycle to next buffer' })
    vim.keymap.set('n', 't', '<C-w>', { desc = 'Navigate buffers' })
    vim.keymap.set('n', 'H', '<C-w>h', { desc = 'Navigate to the previous buffer' })
    vim.keymap.set('n', 'L', '<C-w>l', { desc = 'Navigate to the next buffer' })
    vim.keymap.set(
        'n',
        '<leader>hl',
        '<cmd>lua Snacks.picker.highlights()<cr>',
        { desc = 'Show available highlights in ui.' }
    )
    vim.keymap.set('n', '<S-Tab>', '<Plug>(cokeline-focus-next)', { silent = true, remap = true })
    vim.keymap.set('n', '<C-w><C-c>', '<cmd>close<cr>', { desc = 'Close window' })
    vim.keymap.set(
        'n',
        '<C-n>',
        '<cmd>lua local p = Snacks.picker.get({ source = "explorer" })[1]; if p then p:close() else Snacks.explorer() end<cr>',
        { desc = 'Toggle explorer' }
    )
    vim.keymap.set(
        'n',
        'N',
        '<cmd>lua local p = Snacks.explorer.reveal(); if p then p:focus() end<cr>',
        { desc = 'Focus current file in explorer' }
    )
    vim.keymap.set('n', '<C-t>', '<cmd>lua Snacks.picker()<cr>', { desc = 'Open picker' })
    vim.keymap.set('n', '<C-_>', 'gcc', { remap = true })
    vim.keymap.set('n', '<C-/>', 'gcc', { remap = true })
    vim.keymap.set('n', '<leader>e', '<cmd>e<cr>', { desc = 'Reload file' })
    vim.keymap.set('n', '<leader>fc', '<cmd>lua Snacks.picker.git_log_file()<cr>', { desc = 'Git log for file' })
    vim.keymap.set('n', '<leader><leader>l', '<cmd>Lazy<cr>', { desc = 'Open Lazy' })
    vim.keymap.set('n', '<leader><leader>t', '<cmd>InspectTree<cr>', { desc = 'InspectTree' })
    vim.keymap.set('n', '<leader><leader>p', '<cmd>lua vim.show_pos()<cr>', { desc = 'Show position' })

    vim.keymap.set('v', '<C-c>', '"+y', { desc = 'Yank to OS ClipBoard' })
    vim.keymap.set('v', '<C-_>', 'gc', { remap = true })
    vim.keymap.set('v', '<C-/>', 'gc', { remap = true })
    vim.keymap.set('v', '<C-J>', ":m '>+1<CR>gv=gv", { desc = 'Move selected lines down' })
    vim.keymap.set('v', '<C-K>', ":m '<-2<CR>gv=gv", { desc = 'Move selected lines up' })

    vim.keymap.set(
        '',
        '<Esc>',
        '<cmd>noh<cr><Esc>',
        { desc = 'clears search highlights', noremap = true, silent = true }
    )
end

return M
