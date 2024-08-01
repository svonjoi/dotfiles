#!/bin/sh

# Get the current day of the week (1-7, Monday-Sunday)
weekday=$(date +%u)

v="${COLOR_PRIMARY}"
c=%{F${v}}
nc=%{F-}

# Define a case structure to match the weekday number with the desired format
case $weekday in
    1)
        day="${c}M${nc}󰧟󰧟󰧟󰧟󰧟󰧟"
        ;;
    2)
        day="󰧟${c}T${nc}󰧟󰧟󰧟󰧟󰧟"
        ;;
    3)
        day="󰧟󰧟${c}X${nc}󰧟󰧟󰧟󰧟"
        ;;
    4)
        day="󰧟󰧟󰧟${c}R${nc}󰧟󰧟󰧟"
        ;;
    5)
        day="󰧟󰧟󰧟󰧟${c}F${nc}󰧟󰧟"
        ;;
    6)
        day="󰧟󰧟󰧟󰧟󰧟${c}S${nc}󰧟"
        ;;
    7)
        day="Y"
        day="󰧟󰧟󰧟󰧟󰧟󰧟${c}Y${nc}"
        ;;
    *)
        day="Unknown"
        ;;
esac

echo $day

