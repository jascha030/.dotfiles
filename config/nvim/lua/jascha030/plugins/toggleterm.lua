---@type LazyPluginSpec
local M = {
    'akinsho/toggleterm.nvim',
    lazy = false,
    version = '*',
    keys = {
        -- { mode = 't', '<esc><esc>', [[<C-\><C-n>]], buffer = 0, desc = 'Leave terminal mode' },
        { mode = 't', '<C-t>', [[<C-\><C-n>]], buffer = 0, desc = 'Leave terminal mode' },
        { mode = 't', '<C-w>', [[:close<CR>]], buffer = 0, desc = 'Close terminal' },
    },
}

function M.config(_, opts)
    local silent_opts = {
        noremap = true,
        silent = true,
    }

    local map = vim.keymap.set
    local toggleterm = require('toggleterm')
    local Terminal = require('toggleterm.terminal').Terminal
    local fpmlog, terms, lazygit = nil, {}, nil

    local function create(cmd, options)
        local term_opts = {
            cmd = cmd,
            dir = 'git_dir',
            direction = 'float',
            hidden = true,
            on_open = function(term)
                vim.cmd('startinsert!')

                map('t', '<esc><esc>', [[<C-\><C-n>]], { buffer = term.bufnr })
                map('n', 'q', [[<cmd>close<CR>]], { buffer = term.bufnr })
            end,
        }

        if options ~= nil then
            term_opts = vim.tbl_deep_extend('force', term_opts, options)
        end

        if term_opts.direction == 'float' then
            term_opts.float_opts = BORDERS
        end

        return Terminal:new(term_opts)
    end

    local function tterm_terminal(direction)
        direction = direction or 'float'

        if terms[direction] == nil then
            terms[direction] = create('/bin/zsh --login', { direction = direction })
        end

        terms[direction]:toggle()
    end

    local function tterm_lazygit()
        if lazygit == nil then
            lazygit = create('lazygit', {
                on_open = function(term)
                    vim.cmd('startinsert!')
                    map('n', 'q', [[<cmd>close<CR>]], { buffer = term.bufnr })
                end,
            })
        end

        lazygit:toggle()
    end

    local function tterm_fpmlog()
        if fpmlog == nil then
            fpmlog = create('fpmlog', { direction = 'horizontal' })
        end

        fpmlog:toggle()
    end

    toggleterm.setup(opts)

    map('n', '<leader>tf', function()
        tterm_terminal('float')
    end, silent_opts)

    map('n', '<leader>tb', function()
        tterm_terminal('horizontal')
    end, silent_opts)

    map('n', '<leader>t', function()
        tterm_terminal()
    end, silent_opts)

    map('n', '<leader>fl', function()
        tterm_fpmlog()
    end, silent_opts)

    map('n', '<leader>g', function()
        tterm_lazygit()
    end, silent_opts)
end

return M
