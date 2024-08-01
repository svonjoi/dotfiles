#!/bin/zsh
# ,---- [ ]
# | 
# | $1 workmode
# | $2 enable|disable
# |  
# `----


if [ "$1" = "workmode" ]; then

    if [ "$2" = "enable" ]; then

        dunstctl rule urg_critical enable
        dunstctl rule urg_normal disable
        dunstctl rule urg_low disable

        dunstify -a "t" "workmode enabled" -u critical

    else
        dunstctl rule urg_critical enable
        dunstctl rule urg_normal enable
        dunstctl rule urg_low enable

        dunstify -a "t" "workmode disabled" -u critical
    fi

fi