#!/bin/bash
# run once when system starts
# nohup autostart.sh &

# TODO: ~/.xinitrc

~/.config/scripts/hardware/mouse.sh
~/.config/scripts/hardware/layout.sh

#  не пашет или че?
~/.config/scripts/helpers/setup-remap.sh

# set keybinding
# кривой кал из за капслока выдает кучу варнов. или мб из за ш3 биндов
setsid -f sxhkd

~/.config/scripts/mount-cloud.sh
nohup udiskie --tray &
nohup greenclip daemon &
nohup ~/.config/scripts/explorer/show-in-folder.pl &

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
