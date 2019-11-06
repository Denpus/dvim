cmake_minimum_required(VERSION 2.8.9)

install(FILES dvim.vim DESTINATION $ENV{HOME}/.vim/plugin/dvim)

add_custom_target(
        make-tpl ALL
        COMMAND dffs -o &
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
)
