#!/usr/bin/env bash
#https://man.archlinux.org/man/rofi-script.5.en
#https://davatorium.github.io/rofi/current/rofi.1/#combi-settings
#man rofi-script
#script-mode (not -dmenu)

if [ x"$@" = x"save-current-workspace" ]
then
    i3-resurrect save
    notify-send 'current ws layout saved'
    exit 0
fi


#if [ x"$@" = x"restore-workspace" ]
#then
#    #i3-resurrect ls | awk '$3 == "layout" {print $2}' | rofi -sep '\n' -dmenu -p workspace | xargs -I {} i3-resurrect restore -w {}
#    #notify-send 'yee'
#    exit 0
#fi

echo "save-current-workspace"
#echo "restore-workspace"
