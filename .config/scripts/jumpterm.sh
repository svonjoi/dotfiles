#!/bin/zsh
# ,---- [ ]
# | 
# | $1 terminal a usar  
# | $2 WS_CLASS
# | $3 tui
# |  
# | Check if a terminal with class=$2 is running, if not, spawn it with command $3
# `----
set -x

if [[ $1 == 'kitty' ]] || [[ $1 == 'alacritty' ]]; then
    if ! pgrep -f "$1 --class=$2" > /dev/null; then
        # eval cuz $3 can be composed of multiple words so it is passed with quotes
        eval $1 --class=$2 -e $3 &
        notify-send --icon=clock "Process not found; spawning " "<span color='#57dafd'><tt>$3</tt></span>"
    fi
fi

