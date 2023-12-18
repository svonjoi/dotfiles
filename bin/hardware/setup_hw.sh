#!/bin/bash
# ,---- [ ]
# | Setup hardware parts
# | Need run when reconnect keyboard/mouse
# `----
# set -euo pipefail

HOME=~

# setup mouse
~/bin/hardware/mouse.sh


# fix left mouse click
# sudo udevadm trigger && notify-send "udevadm trigger"


# setup keyboard layout
# если запускать после ремапа, то ремапинг сбрасывается и капс не пашет
#setxkbmap -layout 'us,ru,es'
setxkbmap -layout 'us,ru'

# enable international characters mapping via keyd (this must run after keyd starts)
setxkbmap -option compose:menu

# setup remapping
xmodmap $HOME/.Xmodmap

notify-send "✅ hardware setup done"

# # Function to log messages
# LOG_FILE="/tmp/udev_svonjoi_remap_homescript.log"
# log_message() {
#     local level="$1"
#     local message="$2"
#     local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
#     echo "$timestamp [$level] $message" >> "$LOG_FILE"
# }

# log_message "INFO" "Setup done"
