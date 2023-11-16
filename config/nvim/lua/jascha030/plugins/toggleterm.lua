local silent_opts = { noremap = true, silent = true }

local M = {
    'akinsho/toggleterm.nvim',
    lazy = false,
    priority = 100,
    version = '*',
    keys = {
        { 't', '<esc><esc>', [[<C-\><C-n>]], { noremap = true, buffer = 0 } },
        { 't', '<C-w>', [[:close<CR>]], { noremap = true, buffer = 0 } },
        { 'n', 'q', [[:close<CR>]], { noremmap = true, buffer = 0 } },
    },
}

function M.config(_, _)
    local map = vim.keymap.set
    local toggleterm = require('toggleterm')
    local Terminal = require('toggleterm.terminal').Terminal
    local fpmlog, terminal, lazygit = nil, nil, nil

    local function create(cmd, direction, dir)
        direction = direction or 'float'
        dir = dir or 'git_dir'

        local term_opts = {
            cmd = cmd,
            dir = dir,
            direction = direction,
            hidden = true,
        }

        if direction == 'float' then
            term_opts.float_opts = BORDERS
        end

        return Terminal:new(term_opts)
    end

    function _G.tterm_terminal()
        if terminal == nil then
            terminal = create('/usr/bin/zsh --login')
        end

        terminal:toggle()
    end

    function _G.tterm_lazygit()
        if lazygit == nil then
            lazygit = create('lazygit')
        end

        lazygit:toggle()
    end

    function _G.tterm_fpmlog()
        if fpmlog == nil then
            fpmlog = create('fpmlog', 'horizontal')
        end

        fpmlog:toggle()
    end

    toggleterm.setup({})

    function _G.set_terminal_keymaps()
        map('t', '<esc><esc>', [[<C-\><C-n>]], { noremap = true, buffer = 0 })
        map('t', '<C-w>', [[:close<CR>]], { noremap = true, buffer = 0 })
        map('n', 'q', [[:close<CR>]], { noremap = true, buffer = 0 })
    end

    vim.cmd([[autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()]])

    map('n', '<leader>t', [[<cmd>lua tterm_terminal()<CR>]], silent_opts)
    map('n', '<C-t>', [[<cmd>lua tterm_terminal()<CR>]], silent_opts)
    map('n', '<leader>fl', [[<cmd>lua tterm_fpmlog()<CR>]], silent_opts)
    map('n', '<leader>g', [[<cmd>lua tterm_lazygit()<CR>]], silent_opts)
end

return M
