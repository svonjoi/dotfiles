#!/bin/bash
# run once when system starts
# nohup autostart.sh &

# TODO: ~/.xinitrc

# set keybinding
# кривой кал из за капслока выдает кучу варнов. или мб из за ш3 биндов
setsid -f sxhkd

# NOTE: recently added nohup
nohup ~/.config/scripts/hardware/mouse.sh &
nohup ~/.config/scripts/hardware/layout.sh &
nohup ~/.config/scripts/input/setup-remap &
nohup ~/.config/scripts/input/keyd-dynamic-remap many &
nohup ~/.config/scripts/mount-cloud.sh &

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
