local vim = vim
local api = vim.api

local function nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        api.nvim_command('augroup ' .. group_name)
        api.nvim_command('autocmd!')

        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten({ 'autocmd', def }), ' ')
            api.nvim_command(command)
        end

        api.nvim_command('augroup END')
    end
end

nvim_create_augroups({ open_folds = { { 'BufReadPost,FileReadPost', '*', 'normal zR' } } })

vim.api.nvim_create_autocmd('BufRead', {
    group = vim.api.nvim_create_augroup('CmpSourceCargo', { clear = true }),
    pattern = 'Cargo.toml',
    callback = function()
        require('cmp').setup.buffer({ sources = { { name = 'crates' } } })
    end,
})

vim.cmd([[
  augroup _lsp
    autocmd!
    autocmd FileType plist set ft=xml
    autocmd BufReadPost *.neon set ft=yaml
    autocmd BufReadPost *.ejs.t set ft=embedded_template
    autocmd BufReadPost *.*ignore set ft=gitignore
    autocmd BufReadPost gitignore_global set ft=gitignore
    autocmd BufReadPost *.gitconfig set ft=gitconfig
    autocmd BufReadPost env.local set ft=bash
    autocmd BufReadPost *.cnf set ft=dosini
    autocmd BufReadPost *.antigenrc set ft=zsh
    autocmd BufReadPost Deployfile set ft=json
  augroup end
]])

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'help', 'lspinfo' },
    command = [[nnoremap <buffer><silent> q :close<CR>]],
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'dashboard', 'toggleterm' },
    command = [[nnoremap <buffer><silent> q :q<CR>]],
})
