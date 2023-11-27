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
    autocmd FileType php setlocal omnifunc=phpactor#Complete
    autocmd BufRead,BufNewFile .zsh* set tabstop=4 | set shiftwidth=4
  augroup end

  augroup _ft
    autocmd!
    autocmd BufReadPost *.neon,*.neon.dist set ft=yaml
    autocmd BufReadPost *.tape set ft=tape
    autocmd BufReadPost *.ejs.t set ft=embedded_template
    autocmd BufReadPost *.cnf set ft=dosini
    autocmd BufReadPost *.kdl set ft=kdl
    autocmd BufReadPost *Brewfile set ft=ruby

    " Git
    autocmd BufRead,BufNewFile gitignore_global,*.*ignore set ft=gitignore
    autocmd BufRead,BufNewFile *.gitattributes set ft=gitattributes
    autocmd BufRead,BufNewFile *.gitconfig,gitconfig set ft=gitconfig
    autocmd BufRead,BufNewFile *.md, *.MD set ft=markdown

    " JSON
    autocmd BufRead,BufNewFile Deployfile set ft=json
    autocmd BufRead,BufNewFile *.json.dist set ft=json

    " XML
    autocmd BufNewFile,BufRead *.svg set ft=xml
    autocmd BufNewFile,BufRead *.xml.dist set ft=xml

    " Nginx
    autocmd BufRead,BufNewFile *.nginx set ft=nginx
    autocmd BufRead,BufNewFile */.config/valet/Nginx/* set ft=nginx

    " ZSH
    autocmd BufRead,BufNewFile *.antigenrc set ft=zsh
    autocmd BufRead,BufNewFile .zsh* set ft=zsh 

    " Bash
    autocmd BufRead,BufNewFile env.local set ft=bash

    " Nushell
    autocmd BufRead,BufNewFile *.nu set ft=nu
  
    autocmd FileType help,lspinfo,Trouble nnoremap <buffer><silent> q :close<CR>
    autocmd FileType Trouble nnoremap <buffer><silent> TT :close<CR>
    autocmd FileType dashboard nnoremap <buffer><silent> q :q<CR>
  augroup end
]])
