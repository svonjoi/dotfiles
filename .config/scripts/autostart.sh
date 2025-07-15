#!/bin/bash
# run once when system starts

~/.config/scripts/hardware/mouse.sh
~/.config/scripts/hardware/layout.sh
~/.config/scripts/helpers/setup_remap.sh
~/.config/scripts/cloud.sh

# set keybinding
# killall sxhkd && setsid -f sxhkd
setsid -f sxhkd

nohup udiskie --tray &
nohup greenclip daemon &
nohup ~/.config/scripts/show_in_folder.pl &

#todo: start crow

# kill this shit: sudo killall teamviewerd
# хуйня проситб пароль заебала
# teamviewer --daemon start

# disable power-button
# https://unix.stackexchange.com/questions/547582/how-to-disable-cleanly-the-power-button
nohup systemd-inhibit \
    --what="handle-power-key" \
    --who="disable-shutdown-button script" \
    --why="allows i3 to open shutdown-dialog instead" \
    sleep 1000d

notify-send "autostart done"
