"======================================
"    Script Name:  dvim-build
"    Plugin Name:  DVimbBuild
"        Version:  0.1.12
" @link https://www.reddit.com/r/vim/comments/2bkvii/setlocal_makeprggcc_o_pr_p/
"======================================

let g:build_dir = 'build'
let g:build_target = 'main'

function! s:build_open_vin()
    if exists("s:build_win")
        return
    endif 

    let s:build_win = bufnr("$")

    copen 8
    "setlocal quickfix_title = "77777"
endfunction

func! Build_toggle()
  if exists("s:build_win")
    cclose
    unlet s:build_win
else
    call s:build_open_vin()
  endif
endfunction

function! s:run_window(data)
    "
"  vnew
"  badd CMakeProject
"  buffer CMakeProject
"   setlocal buftype=nofile
" setlocal modifiable
" let s:cmake_project_bufname = "dddddddd"
" setlocal nomodifiable

    redir =>l:out 
    exec ":!" . a:data
    redir end

    cgetexpr l:out

    call s:build_open_vin()
endfunction

function! s:cmd_run(data)
    echo "Run '" . a:data . "' ..."

    let l:out = system(a:data)
    let l:out = substitute(l:out, "reset", "___", "")

    echo l:out
endfunction

function Build_make()
    return "cd " . g:build_dir . " && make "
endfunction

function Build_run_target(target)
    if a:target != "" 
        let g:build_target = a:target
    endif

    exec ":!" . g:build_dir . "/" . g:build_target
endfunction

function Build_make_run()
    return "cd " . g:build_dir . "/ && make " .g:build_target 
endfunction

function Build_cmake_run()
    return "cmake --build " . g:build_dir . " --target " .g:build_target 
endfunction

function! Dbuild_reset()
    call s:cmd_run("dbuild reset")
endfunction

let mrg='main'
let cstd = 99
let g:build_type = 0

function Build_check() 
    if g:build_type
        return
    endif

    silent call mkdir(g:build_dir, 'p')

    if filereadable("CMakeLists.txt") 
        let g:build_type = 3
        let &l:makeprg = Build_cmake()
     elseif filereadable(g:build_dir . "/Makefile") 
         let g:build_type = 2
        let &l:makeprg='cd ./build && make '"
    else
        let g:build_type = 1

        " if %:e == 'c'
        " endif
            set makeprg=gcc\ %:p\ -o\ %:p:r
    endif
endfunction

function! Dbuild_reload()
    let g:build_type = 0

   call Dbuild_reset()
   "call s:run_window("dbuild load")
   "call Build_check()
endfunction

function Build_run(target)
   if a:target != ""
        let g:build_target = a:target
   endif

    if g:build_type == 3 
        let l:cmd =  Build_cmake_run() 
        
      call s:run_window(l:cmd)
     elseif g:build_type == 2
      exec ":!" . Build_make_run() 
    else
        echo "run gcc file"
        :!%:p:r
  endif

  call Build_run_target("")
endfunction

noremap <F8> :call Dbuild_reload()<cr>
noremap <F10> :call Build_run("")<cr>
noremap <F7> :call Build_toggle()<cr>

" 
" CMake generation / reload
"

" au FileType c set makeprg=gcc\ -g\ %\ -o\ %<

command! -nargs=1 Run call Build_run_target(<f-args>)
command! -nargs=1 Build call Build_run(<f-args>)

cnoreabbrev rmake Dbuild_reload
cnoreabbrev dreset Dbuild_reset
autocmd winenter * :call Build_check()
autocmd vimenter * :call Build_check()
autocmd tabenter * :call Build_check()

