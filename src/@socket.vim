"================================================
"    Script Name:  @name
"      File Name:  @fscpath(false)
"         Author:  Denis karabadjak
"           Link:  https://vimhelp.org/channel.txt.html
"
" Copyright (C) Denis Karabadjak <denkar@mail.ru>
"=================================================

function G@prefix\_net_res(channel, msg)
    echo "res"

    silent caddexpr a:msg

    "call ch_close(channel)
endfunction

function s:@prefix\_net_open()
    let address = g:@prefix\_addr . ':' . g:@prefix\_port
    let channel = ch_open(address, {'mode': "nl", 'callback': "G@prefix\_net_res"})

    if ch_status(channel) == "fail"
        "echo "error open channel"
    endif

    return channel
endfunction

function s:@prefix\_net(msg)
    let channel = s:@prefix\_net_open()

    if ch_status(channel) == "fail"
        return 1
    endif

    let path_root = expand('%:p:h')

    call s:build_open_win()
    call ch_sendraw(channel, path_root . " " . a:msg . "0")

    return 0
endfunction

function s:@prefix\_net_oneline(msg)
    let channel = s:@prefix\_net_open()

    if ch_status(channel) == "fail"
        return 1
    endif

    let path_root = expand('%:p:h')

    echo ch_evalraw(channel, path_root . " " . a:msg . "0")

    call ch_close(channel)

    return 0
endfunction
