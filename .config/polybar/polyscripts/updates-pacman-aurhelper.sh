#!/bin/sh

COLOR_ICON="${POLYCOLOR1}"
COLOR_ICON_DISABLED="${POLYCOLOR3}"

# is a script provided by the pacman package manager in Arch Linux.
# It checks for updates without actually modifying the system or the package database.
if ! updates_arch=$(checkupdates 2>/dev/null | wc -l); then
    updates_arch=0
fi

if ! updates_aur=$(yay -Qum 2>/dev/null | wc -l); then
    # if ! updates_aur=$(paru -Qum 2> /dev/null | wc -l); then
    # if ! updates_aur=$(cower -u 2> /dev/null | wc -l); then
    # if ! updates_aur=$(trizen -Su --aur --quiet | wc -l); then
    # if ! updates_aur=$(pikaur -Qua 2> /dev/null | wc -l); then
    # if ! updates_aur=$(rua upgrade --printonly 2> /dev/null | wc -l); then
    updates_aur=0
fi

updates=$((updates_arch + updates_aur))
# 󰑤 󰓦

if [ "$updates" -gt 0 ]; then
    echo "$updates_arch %{F${COLOR_ICON}}󰑤%{F-} $updates_aur"
else
    echo "%{F${COLOR_ICON_DISABLED}}󰑤%{F-}"
fi
