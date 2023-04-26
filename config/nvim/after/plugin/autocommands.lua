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
    autocmd BufReadPost *.tape set ft=tape
    autocmd BufReadPost *.neon.dist set ft=yaml
    autocmd BufReadPost *.xml.dist set ft=xml
    autocmd BufReadPost *.ejs.t set ft=embedded_template
    autocmd BufReadPost *.*ignore set ft=gitignore
    autocmd BufReadPost *.nu set ft=nu
    autocmd BufReadPost gitignore_global set ft=gitignore
    autocmd BufReadPost *.gitattributes set ft=gitattributes
    autocmd BufReadPost *.gitconfig set ft=gitconfig
    autocmd BufReadPost env.local set ft=bash
    autocmd BufReadPost *.cnf set ft=dosini
    autocmd BufReadPost *.kdl set ft=kdl
    autocmd BufReadPost *.antigenrc set ft=zsh
    autocmd BufReadPost Deployfile set ft=json
  augroup end

  autocmd FileType php setlocal omnifunc=phpactor#Complete
]])

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'help', 'lspinfo' },
    command = [[nnoremap <buffer><silent> q :close<CR>]],
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'dashboard', 'toggleterm' },
    command = [[nnoremap <buffer><silent> q :q<CR>]],
})
