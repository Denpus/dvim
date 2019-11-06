"================================================
" Script Name : @fscpath(false)
" Link        : https://www.reddit.com/r/vim/comments/2bkvii/setlocal_makeprggcc_o_pr_p/

" Copyright (C) Denis Karabadjak <denkar@mail.ru>
"=================================================

let mrg='main'
let cstd = 99
let g:build_type = 0

function Build_check()
    if g:build_type
        return
    endif

    "set makeprg=gcc\\\\ %:p\\\\ -o\\\\ %:p:r
    "set makeprg=dbuild
    "au FileType c set makeprg=gcc\\\\ -g\\\\ %\\\\ -o\\\\ %<
    "let &l:makeprg='dbuild target'
endfunction
