vim.cmd([[
  autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
]])

vim.cmd([[
  augroup _lsp
    autocmd!
    autocmd FileType plist set ft=xml
    autocmd BufReadPost *.neon set ft=yaml
    autocmd BufReadPost *.ejs.t set ft=embedded_template
    autocmd BufReadPost *.styluaignore set ft=gitignore
  augroup end
]])

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'help', 'lspinfo' },
    command = [[nnoremap <buffer><silent> q :close<CR>]],
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'dashboard' },
    command = [[nnoremap <buffer><silent> q :q<CR>]],
})
