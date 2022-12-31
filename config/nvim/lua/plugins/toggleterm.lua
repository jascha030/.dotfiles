return {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
        local M = {}

        local MAP_OPTS = { noremap = true, silent = true }

        local map = vim.keymap.set
        local toggleterm = require('toggleterm')
        local Terminal = require('toggleterm.terminal').Terminal
        local fpmlog, terminal, lazygit = nil, nil, nil

        function M.create(cmd, dir, direction)
            dir = dir or 'git_dir'
            direction = direction or 'float'

            local opts = {
                cmd = cmd,
                dir = dir,
                direction = direction,
                hidden = true,
            }
            if direction == 'float' then
                opts.float_opts = BORDER
            end

            return Terminal:new(opts)
        end

        function M.get_terminal()
            if terminal == nil then
                terminal = Terminal:new({
                    cmd = '/usr/local/bin/zsh --login',
                    dir = 'git_dir',
                    hidden = true,
                    direction = 'float',
                    float_opts = BORDER,
                })
            end

            terminal:toggle()
        end

        function M.get_lazygit()
            if lazygit == nil then
                lazygit = Terminal:new({
                    cmd = 'lazygit',
                    dir = 'git_dir',
                    hidden = true,
                    direction = 'float',
                    float_opts = BORDER,
                })
            end

            lazygit:toggle()
        end

        function M.tterm_fpmlog()
            if fpmlog == nil then
                fpmlog = Terminal:new({ cmd = 'fpmlog', direction = 'horizontal' })
            end

            fpmlog:toggle()
        end

        toggleterm.setup({})

        function _G.set_terminal_keymaps()
            local opts = { noremap = true, buffer = 0 }
            map('t', '<esc><esc>', [[<C-\><C-n>]], opts)
            map('t', '<C-w>', [[:close<CR>]], opts)
            map('n', 'q', [[:close<CR>]], opts)
        end

        vim.cmd([[autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()]])

        map('n', '<leader>t', [[:lua M.get_terminal():toggle()]], MAP_OPTS)
        map('n', '<C-t>', [[:lua M.get_terminal():toggle]], MAP_OPTS)
        map('n', '<leader>fl', [[:lua M.get_fpmlog():toggle()]], MAP_OPTS)
        map('n', '<leader>g', [[:lua M.get_lazygit():toggle()]], MAP_OPTS)
    end,
}
