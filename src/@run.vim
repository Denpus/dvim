"================================================
" Script Name:  @fscpath(false)
"
" Copyright (C) Denis Karabadjak <denkar@mail.ru>
"=================================================

function! s:@prefix\(cmd)
    if !s:@prefix\_net(a:cmd)
        return
    endif

    call s:@prefix\_run(a:cmd)
endfunction

function! s:@prefix\_oneline(cmd)
    let ncmd = "--oneline " . a:cmd

    if !s:@prefix\_net_oneline(ncmd)
        return
    endif

    call s:@prefix\_run_oneline(ncmd)
endfunction
