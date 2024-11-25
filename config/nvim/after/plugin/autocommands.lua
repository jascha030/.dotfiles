require('jascha030.core.autocommands').nvim_create_augroups(require('jascha030').get_config('augroups'))

-- I was too lazy to do everything lua hehehehe.
vim.cmd([[
  augroup _ft
    autocmd!
    autocmd BufReadPost *.tape set ft=tape
    autocmd BufReadPost *.ejs.t set ft=embedded_template
    autocmd BufReadPost *.cnf set ft=dosini
    autocmd BufReadPost *.kdl set ft=kdl
    autocmd BufReadPost *Brewfile set ft=ruby
    " Git
    autocmd BufRead,BufNewFile gitignore_global,*.*ignore set ft=gitignore
    autocmd BufRead,BufNewFile *.gitattributes set ft=gitattributes
    autocmd BufRead,BufNewFile *.gitconfig,gitconfig set ft=gitconfig
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
    " Neon
    autocmd BufRead,BufNewFile *.neon,*.neon.dist set ft=neon
    " INI
    autocmd BufRead,BufNewFile *.ini set ft=ini
    " PHP 
    autocmd BufRead,BufNewFile composer.json,.phpactor.json set tabstop=4 | set shiftwidth=4 | set expandtab | set softtabstop=4
    autocmd BufRead,BufNewFile composer.lock set ft=json
  augroup end
]])
