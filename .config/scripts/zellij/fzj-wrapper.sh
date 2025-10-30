#!/bin/bash

source $HOME/.config/scripts/lib/ui

FZJ=$HOME/.config/scripts/zellij/fzj.sh

clear
ui_box "ZELLIJ"

OPTIONS=$($FZJ --help | awk '/^\s*-{1,2}[a-z]/ && $1 != "--help" {gsub(/^[[:space:]]*/, ""); print}')

# CHOICE=$(echo "$OPTIONS" | fzf --prompt="Select an option for fzj: " --height=10 --border --ansi)

# Extract the flag (first word)
# FLAG=$(echo "$CHOICE" | awk '{print $1}')

CHOICE=$(printf '%s\n' "${OPTIONS[@]}" | ui-choser)

# Extract the flag (first part before |)
FLAG=$(echo "$CHOICE" | awk '{print $1}')

if [[ -n "$FLAG" ]]; then
    clear
    gum style --foreground 76 "Executing: $FLAG" --margin "1 0"
    $FZJ "$FLAG"
else
    clear
    gum style --foreground 196 --bold "No option selected" --align center
    exit 1
fi
