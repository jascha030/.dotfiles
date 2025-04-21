---@type LazyPluginSpec
local M = {
    'akinsho/toggleterm.nvim',
    lazy = false,
    version = '*',
    keys = {
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
    local fpmlog = nil

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
            term_opts.float_opts = { border = BORDER }
        end

        return Terminal:new(term_opts)
    end

    local function tterm_fpmlog()
        if fpmlog == nil then
            fpmlog = create('fpmlog', { direction = 'horizontal' })
        end

        fpmlog:toggle()
    end

    toggleterm.setup(opts)

    map('n', '<leader>fl', function()
        tterm_fpmlog()
    end, silent_opts)
end

return M
