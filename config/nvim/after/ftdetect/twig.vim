autocmd BufNewFile,BufRead *.twig set filetype=twig
autocmd FileType twig setlocal commentstring={#\ %s\ #}
set textwidth=0 " do not automatically wrap text when typing

function! TwigIndent()
    setlocal indentexpr=GetTwigIndent()
endfunction

function! GetTwigIndent()
    if getline(v:lnum) =~ '^\s*{%\s*end'
        return indent(prevnonblank(v:lnum)) - &shiftwidth
    elseif getline(v:lnum) =~ '^\s*{%\s*'
        return indent(prevnonblank(v:lnum)) + &shiftwidth
    else
        return indent(prevnonblank(v:lnum))
    endif
endfunction

" Enable twig indent function
autocmd FileType twig call TwigIndent()

" Add find_usages mapping
autocmd FileType twig nnoremap <buffer> <leader>fu <cmd>call twig#FindUsages()<cr>

" Goes to next view
autocmd FileType twig nmap <Leader>lv <Cmd>call search('include')<CR>t/gf
