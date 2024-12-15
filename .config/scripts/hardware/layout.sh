#!/bin/bash

# setup keyboard layout
#setxkbmap -layout 'us,ru,es'
# NOTE: если запускать после ремапа, то ремапинг сбрасывается и капс не пашет
setxkbmap -layout 'us,ru'

# enable international characters mapping via keyd (this must run after keyd starts)
setxkbmap -option compose:menu
