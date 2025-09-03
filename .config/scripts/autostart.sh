#!/bin/bash
# run once when system starts

# TODO: ~/.xinitrc

~/.config/scripts/hardware/mouse.sh
~/.config/scripts/hardware/layout.sh
~/.config/scripts/helpers/setup-remap.sh
~/.config/scripts/mount-cloud.sh

# set keybinding
setsid -f sxhkd

nohup udiskie --tray &
nohup greenclip daemon &
nohup ~/.config/scripts/show_in_folder.pl &

# disable power-button
# https://unix.stackexchange.com/questions/547582/how-to-disable-cleanly-the-power-button
nohup systemd-inhibit \
    --what="handle-power-key" \
    --who="disable-shutdown-button script" \
    --why="allows i3 to open shutdown-dialog instead" \
    sleep 1000d

# enable fucking CTRL+ALT+Fx keybinding for tty switch
setxkbmap -option '' -print | xkbcomp -I$HOME/.xkb -xkm - $DISPLAY

notify-send "autostart done"
