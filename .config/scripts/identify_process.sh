#!/bin/zsh
# ,---- [ ]
# | 
# `----

# notify-send "Process Name" "$(xprop -id $(xdotool getmouselocation --shell | grep WINDOW | cut -d '=' -f 2) | grep WM_CLASS | awk -F '[""]' '{print $2}')"
notify-send "Process Name" "$(xprop -id $(xdotool getmouselocation --shell | grep WINDOW | cut -d '=' -f 2) | grep WM_CLASS)"
notify-send "Process Name" "$(xprop -id $(xdotool getmouselocation --shell | grep WINDOW | cut -d '=' -f 2))"