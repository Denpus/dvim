"======================================
"    Plugin Name:  @name
"    Description:  @description
"        Version:  @version
"         Author:  Denis karabadjak
"
" Join all files in big one file
"
" Copyright (C) Denis Karabadjak <denkar>
"======================================

@include("src/variables.vim" "let g:")
@include("src/window.vim" "function")
@include("src/init.vim" "let mrg")
@include("src/run.vim" "function")
@include("src/cmd.vim" "function")
@include("src/socket.vim" "function")
@include("src/save.vim" "function")
@include("src/autocmd.vim" "noremap")
