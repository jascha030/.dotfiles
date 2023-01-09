local opts = { noremap = true, buffer = 0 }

return {
    'akinsho/toggleterm.nvim',
    lazy = false,
    priority = 100,
    version = '*',
    keys = {
        { 't', '<esc><esc>', [[<C-\><C-n>]], opts },
        { 't', '<C-w>', [[:close<CR>]], opts },
        { 'n', 'q', [[:close<CR>]], opts },
    },
    config = function()
        local MAP_OPTS = { noremap = true, silent = true }

        local map = vim.keymap.set
        local toggleterm = require('toggleterm')
        local Terminal = require('toggleterm.terminal').Terminal
        local fpmlog, terminal, lazygit = nil, nil, nil

        local function create(cmd, direction, dir)
            direction = direction or 'float'
            dir = dir or 'git_dir'

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

        function _G.tterm_terminal()
            if terminal == nil then
                terminal = create('/usr/local/bin/zsh --login')
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
            local opts = { noremap = true, buffer = 0 }
            map('t', '<esc><esc>', [[<C-\><C-n>]], opts)
            map('t', '<C-w>', [[:close<CR>]], opts)
            map('n', 'q', [[:close<CR>]], opts)
        end

        vim.cmd([[autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()]])

        map('n', '<leader>t', [[<cmd>lua tterm_terminal()<CR>]], MAP_OPTS)
        map('n', '<C-t>', [[<cmd>lua tterm_terminal()<CR>]], MAP_OPTS)
        map('n', '<leader>fl', [[<cmd>lua tterm_fpmlog()<CR>]], MAP_OPTS)
        map('n', '<leader>g', [[<cmd>lua tterm_lazygit()<CR>]], MAP_OPTS)
    end,
}
