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
    local map_opts = { noremap = true, buffer = 0 }

    return {
        { 't', '<C-t>', [[<C-\><C-n>]], map_opts },
        { 't', '<C-w>', [[:close<CR>]], map_opts },
        { 'n', 'q', [[:close<CR>]], map_opts },
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

    function _G.set_terminal_keymaps()
        map('t', '<esc><esc>', [[<C-\><C-n>]], { noremap = true, buffer = 0 })
        map('t', '<C-w>', [[:close<CR>]], { noremap = true, buffer = 0 })
        map('n', 'q', [[:close<CR>]], { noremap = true, buffer = 0 })
    end

    vim.cmd([[autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()]])

    map('n', '<leader>tf', function()
        tterm_terminal('float')
    end, silent_opts)

    map('n', '<leader>tb', function()
        tterm_terminal('horizontal')
    end, silent_opts)

    -- map('n', '<C-t>', [[<cmd>lua tterm_terminal()<CR>]], silent_opts)
    map('n', '<leader>fl', [[<cmd>lua tterm_fpmlog()<CR>]], silent_opts)
    map('n', '<leader>g', [[<cmd>lua tterm_lazygit()<CR>]], silent_opts)
end

return M
