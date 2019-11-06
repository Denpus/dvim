"================================================
" File Name:  @fscpath(false)
"
" Copyright (C) Denis Karabadjak <denkar@mail.ru>
"=================================================

function s:@prefix\_save()
    let name = expand("%:t")

    if name[0:0] == "\@"
        silent! w
        call s:@prefix\_oneline("-o" . name[1:-1])
    else
        :w
    endif
endfunction

cnoreabbrev dw :call s:@prefix\_save()
