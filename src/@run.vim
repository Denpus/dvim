"================================================
" Script Name:  @fscpath(false)
"
" Copyright (C) Denis Karabadjak <denkar@mail.ru>
"=================================================

function! s:cmd_run(data)
    echo ":!" . a:data
    "echo "echo -e '\\033[31;1;4mHello\\033[0m'"
    let l:out = system(a:data)
    "let l:out = substitute(l:out, "\\n", " ", "")
    echo l:out[0:-2]
endfunction

function Dbuildmin(cmd)
    call s:cmd_run("dbuild " . a:cmd)
endfunction

function Dbuild(cmd)
    call s:run_window("dbuild " . a:cmd)
endfunction

function Dbuildrun(cmd)
    call s:run_window("dbuild target " . a:cmd)
endfunction
