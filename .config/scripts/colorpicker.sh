#!/bin/sh
c=$(gpick -s -o)
echo "$c" | xclip -sel c
notify-send "$c" "<span color='$c'><tt>ur fucking color here</tt></span>"
