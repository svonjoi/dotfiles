#!/bin/bash

lock() {
    # https://github.com/betterlockscreen/betterlockscreen?tab=readme-ov-file#configuration
    # https://tools.suckless.org/slock/

    # must have png file header; convert <image> image.png
    # i3lock -c 000000 -k -f -i ~/Pictures/_lock/elfart.png

    ~/.config/scripts/i3_scripts/i3lock-fancy-pizdati --greyscale

    # эта хуйня оповещения не пикселит
    # i3lock-fancy -p &
}

case "$1" in
lock)
    lock
    ;;
logout)
    i3exit logout
    ;;
suspend)
    # this way screen is locked before your laptop suspends
    # TODO: not working
    # xss-lock --transfer-sleep-lock -s ${XDG_SESSION_ID} -v -- i3lock --nofork

    nmcli radio wifi off
    i3exit suspend
    ;;
hibernate)

    # TODO: kill ocaml?
    killall keepassxc
    notify-send "keepassxc killed, hibernating.."

    i3exit hibernate
    # lock && systemctl hibernate
    ;;
reboot)
    systemctl reboot
    ;;
shutdown)
    systemctl poweroff
    ;;
switch)
    i3exit switch_user
    ;;
,*)
    echo "Usage: $0 {lock|logout|suspend|hibernate|reboot|shutdown|switch}"
    exit 2
    ;;
esac

exit 0
