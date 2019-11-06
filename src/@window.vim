"================================================
"   File Name : @fscpath(false)
"        Link : https://vimhelp.org/channel.txt.html
"
" Copyright (C) Denis Karabadjak <denkar@mail.ru>
"=================================================

function! s:build_open_win()
    if exists("s:build_win")
        return
    endif

    let s:build_win = bufnr("$")

    copen 8
    "setlocal quickfix_title = "Cmake"
endfunction

" Show/hide window

function s:build_win_toggle()
  if exists("s:build_win")
    cclose
    unlet s:build_win
else
    call s:build_open_win()
  endif
endfunction

function! s:run_window(data)
    "  vnew
    "  badd CMakeProject
    "  buffer CMakeProject
    "   setlocal buftype=nofile
    " setlocal modifiable
    " let s:cmake_project_bufname = "Win name"
    " setlocal nomodifiable

    echo ":!" . a:data
    "redir =>l:out
    "silent exec ":!" . a:data
    "redir end
    let l:out = system(a:data)

    silent cgetexpr l:out

    call s:build_open_win()
endfunction
