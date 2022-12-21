#!/bin/bash

source ./simple_curses.sh

main (){
    window "ddev Easy cms" "blue"
    append "Thanks for using ddev Easy cms." 
    addsep
    append "author:"
    append "halt23 (Sam Maas)"
    endwin
    window "Help the project." "yellow"
    append "contribute:"
    append "https://github.com/halt23/ddev-easy-cms"
    endwin

    window "info" "green"
    append "You installed $cms"
    addsep
    append "It is all installed in $path_dir"
    addsep
    append "you can reach it on the following url:"
    append "$url"
    endwin

    window "READ!!" "red"
    append "If you need help you can read the docs on:"
    append "https://github.com/halt23/ddev-easy-cms"
    addsep
    append "it is safe to close this window your site will stil be reachable"
    endwin


}

main_loop -t 60