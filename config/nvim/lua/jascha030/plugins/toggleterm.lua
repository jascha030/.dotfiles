---@type LazyPluginSpec
local M = {
    'akinsho/toggleterm.nvim',
    lazy = false,
    version = '*',
}

local silent_opts = {
    noremap = true,
    silent = true,
}

function M.keys(_, _)
    return {
        { mode = 't', '<C-t>', [[<C-\><C-n>]], noremap = true, buffer = 0, desc = "Leave terminal mode" },
        { mode = 't', '<C-w>', [[:close<CR>]], noremap = true, buffer = 0, desc = "Close terminal" },
    }
end

function M.config(_, opts)
    local map = vim.keymap.set
    local toggleterm = require('toggleterm')
    local Terminal = require('toggleterm.terminal').Terminal
    local fpmlog, terms, lazygit = nil, {}, nil

    local function create(cmd, direction, dir)
        direction = direction or 'float'
        dir = dir or 'git_dir'

        local term_opts = {
            cmd = cmd,
            dir = dir,
            direction = direction,
            hidden = true,
            on_open = function(term)
                vim.cmd('startinsert!')
                map('t', '<esc><esc>', [[<C-\><C-n>]], { noremap = true, buffer = term.bufnr })
                map('n', 'q', [[<cmd>close<CR>]], { noremap = true, buffer = term.bufnr })
            end
        }

        if direction == 'float' then
            term_opts.float_opts = BORDERS
        end

        return Terminal:new(term_opts)
    end

    function _G.tterm_terminal(direction)
        direction = direction or 'float'

        if terms[direction] == nil then
            terms[direction] = create('/bin/zsh --login', direction)
        end

        terms[direction]:toggle()
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

    toggleterm.setup(opts)

    map('n', '<leader>tf', function()
        tterm_terminal('float')
    end, silent_opts)

    map('n', '<leader>tb', function()
        tterm_terminal('horizontal')
    end, silent_opts)

    map('n', '<leader>t', [[<cmd>lua tterm_terminal()<CR>]], silent_opts)
    map('n', '<C-t>', [[<cmd>lua tterm_terminal()<CR>]], silent_opts)
    map('n', '<leader>fl', [[<cmd>lua tterm_fpmlog()<CR>]], silent_opts)
    map('n', '<leader>g', [[<cmd>lua tterm_lazygit()<CR>]], silent_opts)
    -- map('n', '<C-t>', [[<cmd>lua tterm_terminal()<CR>]], silent_opts)
    map('n', '<leader>fl', [[<cmd>lua tterm_fpmlog()<CR>]], silent_opts)
    map('n', '<leader>g', [[<cmd>lua tterm_lazygit()<CR>]], silent_opts)
end

return M
