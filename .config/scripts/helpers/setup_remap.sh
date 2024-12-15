#!/bin/bash

# calling this script from i3 not working the same way as calling it from terminal directly
#
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

# xmodmap -verbose $HOME/.Xmodmap >/tmp/xmodmap_i3.log 2>&1
xmodmap $HOME/.Xmodmap && notify-send "xmodmap applied"
