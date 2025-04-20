#!/bin/bash
#https://man.archlinux.org/man/rofi-script.5.en
#https://davatorium.github.io/rofi/current/rofi.1/#combi-settings
#man rofi-script
#script-mode (not -dmenu)

if [ x"$@" = x"save-current-workspace" ]; then
	i3-resurrect save
	notify-send "current ws layout saved"
	exit 0
fi

# TODO:
if [ x"$@" = x"restore-current-workspace" ]; then

	# i3-msg -t get_workspaces |
	#   jq '.[] | select(.focused==true).name' |
	#   cut -d"\"" -f2

	# i3-resurrect ls | awk '$3 == "layout" {print $2}'
	# NOTE: DO NOT LAUNCH ROFI FROM ROFI
	# TODO: nested rofi
	# https://github.com/giomatfois62/rofi-desktop
	# https://www.reddit.com/r/linux/comments/yapr0f/rofidekstop_a_rofi_powered_menu_driven_desktop/

	# TODO: also see https://pastebin.com/RD6Fgzub

	chosen=$(i3-resurrect ls | awk '$3 == "layout" {print $2}' | rofi -dmenu -i)

	# case "$chosen" in
	# "") command ;;
	# *) exit 1 ;;
	# esac

	# i3-resurrect restore -w $chosen
	notify-send "$chosen"

	# xargs -I {} i3-resurrect restore -w {}

	exit 0
fi

# если в начало вывести, то оно не закрывает рофи после селекта))
echo "save-current-workspace"
echo "restore-current-workspace"
