"======================================
"    Plugin Name:  dvim
"    Description:  Dvim - control in VIM save file, auto save file and template (@), support cmake with targets
"        Version:  0.2.1.0
"         Author:  Denis karabadjak
"
" Join all files in big one file
"
" Copyright (C) Denis Karabadjak <denkar>
"======================================

let g:build_dir = 'build'
let g:build_target = 'main'
let g:dvim_port = 9999
let g:dvim_addr = "localhost"

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

let mrg='main'
let cstd = 99
let g:build_type = 0

function Build_check()
    if g:build_type
        return
    endif

    "set makeprg=gcc\ %:p\ -o\ %:p:r
    "set makeprg=dbuild
    "au FileType c set makeprg=gcc\ -g\ %\ -o\ %<
    "let &l:makeprg='dbuild target'
endfunction

function! s:dvim(cmd)
    if !s:dvim_net(a:cmd)
        return
    endif

    call s:dvim_run(a:cmd)
endfunction

function! s:dvim_oneline(cmd)
    let ncmd = "--oneline " . a:cmd

    if !s:dvim_net_oneline(ncmd)
        return
    endif

    call s:dvim_run_oneline(ncmd)
endfunction

function! s:cmd_run(data)
    echo ":!" . a:data
    "echo "echo -e '033[31;1;4mHello033[0m'"
    let l:out = system(a:data)
    "let l:out = substitute(l:out, "n", " ", "")
    echo l:out[0:-2]
endfunction

function s:dvim_run_oneline(cmd)
    call s:cmd_run("dff " . a:cmd)
endfunction

function s:dvim_run(cmd)
    call s:run_window("dff " . a:cmd)
endfunction

function Dbuildrun(cmd)
    call s:run_window("dffs target " . a:cmd)
endfunction

function Gdvim_net_res(channel, msg)
    echo "res"

    silent caddexpr a:msg

    "call ch_close(channel)
endfunction

function s:dvim_net_open()
    let address = g:dvim_addr . ':' . g:dvim_port
    let channel = ch_open(address, {'mode': "nl", 'callback': "Gdvim_net_res"})

    if ch_status(channel) == "fail"
        "echo "error open channel"
    endif

    return channel
endfunction

function s:dvim_net(msg)
    let channel = s:dvim_net_open()

    if ch_status(channel) == "fail"
        return 1
    endif

    let path_root = expand('%:p:h')

    call s:build_open_win()
    call ch_sendraw(channel, path_root . " " . a:msg . "0")

    return 0
endfunction

function s:dvim_net_oneline(msg)
    let channel = s:dvim_net_open()

    if ch_status(channel) == "fail"
        return 1
    endif

    let path_root = expand('%:p:h')

    echo ch_evalraw(channel, path_root . " " . a:msg . "0")

    call ch_close(channel)

    return 0
endfunction

function s:dvim_save()
    let name = expand("%:t")

    if name[0:0] == "@"
        silent! w
        call s:dvim_oneline("-o" . name[1:-1])
    else
        :w
    endif
endfunction

cnoreabbrev dw :call s:dvim_save()

noremap <s-F4> :call s:dvim_oneline("clear")<cr>
noremap <F8> :call s:dvim_oneline("targets")<cr>
noremap <F7> :call s:build_win_toggle()<cr>
noremap <S-F8> :call s:dvim("load")<cr>
noremap <s-F1> :call s:dvim_oneline("reset")<cr>
noremap <F10> :call Build_run("")<cr>
noremap <F1> :call s:dvim_oneline("load")<cr>

command! -nargs=1 Build call Dbuildrun(<f-args>)
command! -nargs=1 Dvim call s:dvim(<f-args>)
command! -nargs=1 Dv call s:dvim_oneline(<f-args>)

cnoreabbrev bload :call Dbuild("load")
cnoreabbrev breset :call Dbuild("reset")
cnoreabbrev dw :call s:dvim_save()

autocmd WinEnter * :call Build_check()
autocmd VimEnter * :call Build_check()
autocmd TabEnter * :call Build_check()
" Save changed
autocmd TextChanged * nested call s:dvim_save()
autocmd InsertLeave * nested call s:dvim_save()
" Default syntax for file
autocmd BufReadPost @CMakeLists.txt set syntax=cmake

