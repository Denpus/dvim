"================================================
" Script Name:  @fscpath(false)
"
" Copyright (C) Denis Karabadjak <denkar@mail.ru>
"=================================================

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

au BufReadPost \@CMakeLists.txt set syntax=cmake
