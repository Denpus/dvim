"================================================
"    Script Name:  @name
"      File Name:  @fscpath(false)
"         Author:  Denis karabadjak
"
" Copyright (C) Denis Karabadjak <denkar@mail.ru>
"=================================================

" Keyboard control
noremap <s-F4> :call s:@prefix\_oneline("clear")<cr>
noremap <F8> :call s:@prefix\_oneline("targets")<cr>
noremap <F7> :call s:build_win_toggle()<cr>
noremap <S-F8> :call s:@prefix\("load")<cr>
noremap <s-F1> :call s:@prefix\_oneline("reset")<cr>
noremap <F10> :call Build_run("")<cr>
noremap <F1> :call s:@prefix\_oneline("load")<cr>

command! -nargs=1 Build call Dbuildrun(<f-args>)
command! -nargs=1 Dvim call s:@prefix\(<f-args>)
command! -nargs=1 Dv call s:@prefix\_oneline(<f-args>)

cnoreabbrev bload :call Dbuild("load")
cnoreabbrev breset :call Dbuild("reset")
cnoreabbrev dw :call s:@prefix\_save()

autocmd WinEnter * :call Build_check()
autocmd VimEnter * :call Build_check()
autocmd TabEnter * :call Build_check()
" Save changed
autocmd TextChanged * nested call s:@prefix\_save()
autocmd InsertLeave * nested call s:@prefix\_save()
" Default syntax for file
autocmd BufReadPost \@CMakeLists.txt set syntax=cmake
