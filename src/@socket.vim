"================================================
" Script Name : @fscpath(false)
" Link        : https://vimhelp.org/channel.txt.html
"
" Copyright (C) Denis Karabadjak <denkar@mail.ru>
"=================================================

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
