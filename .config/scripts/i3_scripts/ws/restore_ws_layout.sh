#!/bin/bash
# restore layout: windows and position; bind layout for specific i3 workspace
i3-resurrect ls | awk '$3 == "layout" {print $2}' | rofi -sep '\n' -dmenu -multi-select -p 'restore workspace' | xargs -I {} i3-resurrect restore -w {}
