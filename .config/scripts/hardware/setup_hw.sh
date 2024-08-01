#!/bin/bash
# ,---- [ setup hardware ]
# | Setup hardware parts
# | Need run when reconnect keyboard/mouse
# `----
# set -euo pipefail

HOME=~

# setup mouse
~/.config/scripts/hardware/mouse.sh


# Fox left click usually dies after wakeup from sleep
# https://askubuntu.com/questions/1248131/20-04-mouse-left-click-not-working
# pendiente automatizar; meter en hardware/setup_hw.sh. Pero como necesita sudo,
# hay k meter scriptpath into `sudo visudo` -> `<username> ALL=(ALL) NOPASSWD: <script_path>`
# sudo udevadm trigger && notify-send "udevadm trigger"


# setup keyboard layout
# если запускать после ремапа, то ремапинг сбрасывается и капс не пашет
#setxkbmap -layout 'us,ru,es'
setxkbmap -layout 'us,ru'

# enable international characters mapping via keyd (this must run after keyd starts)
setxkbmap -option compose:menu

# setup remapping
# calling this script from i3 not working the same way as calling it from terminal directly
# ╭─svonjoi@svonux /tmp
# ╰─$ delta /tmp/xmodmap.log /tmp/xmodmap_i3.log
# ──────────────────────┐
# tmp/xmodmap_i3.log:1: │
# ──────────────────────┘
# │    │                                                                   │  1 │xmodmap:  please release the following keys within 2 seconds:
# │    │                                                                   │  2 │    grave (keysym 0x60, keycode 49)
# │    │                                                                   │  3 │    Super_L (keysym 0xffeb, keycode 133)
# │  1 │! /home/svonjoi/.Xmodmap:                                          │  4 │! /home/svonjoi/.Xmodmap:
# │  2 │! 1:  remove mod1 = Alt_R                                          │  5 │! 1:  remove mod1 = Alt_R
# │  3 │! Keysym Alt_R (0xffea) corresponds to keycode(s) 0x6c             │  6 │! Keysym Alt_R (0xffea) corresponds to keycode(s) 0x6c 
xmodmap -verbose $HOME/.Xmodmap > /tmp/xmodmap_i3.log 2>&1

notify-send "Hardware setup done =)"

# # Function to log messages
# LOG_FILE="/tmp/udev_svonjoi_remap_homescript.log"
# log_message() {
#     local level="$1"
#     local message="$2"
#     local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
#     echo "$timestamp [$level] $message" >> "$LOG_FILE"
# }

# log_message "INFO" "Setup done"
