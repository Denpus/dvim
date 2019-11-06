"================================================
" Script Name:  @fscpath(false)
"
" Copyright (C) Denis Karabadjak <denkar@mail.ru>
"=================================================

function Dbuildsave()
    let name = expand("%:t")

    if name[0:0] == "\@"
        silent! w
        call Dbuild_srv_min("-o" . name[1:-1])
    else
        :w
    endif
endfunction
