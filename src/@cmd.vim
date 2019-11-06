function! s:cmd_run(data)
    echo ":!" . a:data
    "echo "echo -e '\\033[31;1;4mHello\\033[0m'"
    let l:out = system(a:data)
    "let l:out = substitute(l:out, "\\n", " ", "")
    echo l:out[0:-2]
endfunction

function s:@prefix\_run_oneline(cmd)
    call s:cmd_run("dff " . a:cmd)
endfunction

function s:@prefix\_run(cmd)
    call s:run_window("dff " . a:cmd)
endfunction

function Dbuildrun(cmd)
    call s:run_window("dffs target " . a:cmd)
endfunction
