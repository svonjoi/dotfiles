#!/bin/zsh
# ,---- [ ]
# | 
# | $1 terminal a usar  
# | $2 WS_CLASS
# | $3 tui
# |  
# `----


if [[ $1 == 'kitty' ]]; then

    # pgrep -f "kitty --class=$2" > /dev/null || kitty --class=$2 -e $3

    if ! pgrep -f "kitty --class=$2" > /dev/null; then
        kitty --class=$2 -e $3 &
        notify-send "Process not found; Spawning $3 with class=$2"
    fi

fi

if [[ $1 == 'alacritty' ]]; then

    # pgrep -f "kitty --class=$2" > /dev/null || kitty --class=$2 -e $3

    if ! pgrep -f "alacritty --class=$2" > /dev/null; then
        alacritty --class=$2 -e $3 &
        notify-send "Process not found; Spawning $3 with class=$2"
    fi

fi