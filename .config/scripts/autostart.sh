#!/bin/bash
# run once when system starts

~/.config/scripts/hardware/mouse.sh
~/.config/scripts/hardware/layout.sh
~/.config/scripts/helpers/setup_remap.sh
~/.config/scripts/mount_cloud.sh

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

notify-send "autostart done"
