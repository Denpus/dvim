"======================================
"    Script Name:  dvim-build
"    Plugin Name:  DVimbBuild
"        Version:  0.1.12
" @link https://www.reddit.com/r/vim/comments/2bkvii/setlocal_makeprggcc_o_pr_p/
"======================================

let g:build_dir = 'build'
let g:build_target = 'main'

function! s:build_open_win()
    if exists("s:build_win")
        return
    endif

    let s:build_win = bufnr("$")

    copen 8
    "setlocal quickfix_title = "Cmake"
endfunction

" Show/hide window

func! Build_win_toggle()
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



function! s:cmd_run(data)
    echo ":!" . a:data
    "echo "echo -e '\033[31;1;4mHello\033[0m'"
    let l:out = system(a:data)
    "let l:out = substitute(l:out, "\n", " ", "")
    echo l:out[0:-2]
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

function Dbuildmin(cmd)
    call s:cmd_run("dbuild " . a:cmd)
endfunction

function Dbuild(cmd)
    call s:run_window("dbuild " . a:cmd)
endfunction

function Dbuildrun(cmd)
    call s:run_window("dbuild target " . a:cmd)
endfunction

func Dres(channel, msg)
    echo "res"

    silent caddexpr a:msg

    "call ch_close(channel)
endfunc

func Dbuildsrv(msg)
    let path_root = expand('%:p:h')
    let channel = ch_open('localhost:9999', {'mode': "nl", 'callback': "Dres"})

    call s:build_open_win()
    call ch_sendraw(channel, path_root . " " . a:msg . "0")
endfunc

func Dbuild_srv_min(msg)
    let path_root = expand('%:p:h')
    let channel = ch_open('localhost:9999', {'mode': "nl"})

    echo ch_evalraw(channel, path_root . " " . a:msg . "0")

    call ch_close(channel)
endfunc


function Dbuildsave()
    let name = expand("%:t")

    if name[0:0] == "@"
        silent! w
        call Dbuild_srv_min("-o" . name[1:-1])
    else
        :w
    endif
endfunction

noremap <s-F4> :call Dbuild_srv_min("clear")<cr>
noremap <F8> :call Dbuild_srv_min("targets")<cr>
noremap <F7> :call Build_win_toggle()<cr>
noremap <S-F8> :call Dbuildsrv("load")<cr>
noremap <s-F1> :call Dbuild_srv_min("reset")<cr>
noremap <F10> :call Build_run("")<cr>
noremap <F1> :call Dbuild_srv_min("load")<cr>


command! -nargs=1 Build call Dbuildrun(<f-args>)

cnoreabbrev bload :call Dbuild("load")
cnoreabbrev breset :call Dbuild("reset")
autocmd winenter * :call Build_check()
autocmd vimenter * :call Build_check()
autocmd tabenter * :call Build_check()

au TextChanged * nested call Dbuildsave()
au InsertLeave * nested call Dbuildsave()

au BufReadPost @CMakeLists.txt set syntax=cmake
