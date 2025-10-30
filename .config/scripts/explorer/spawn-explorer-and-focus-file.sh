#!/bin/sh

# дергаю с обсы, show in folder (tlg)

if [ -z "$1" ]; then
    echo "Usage: this_fucking_script <text>"
    return 1
fi

# ~/.config/scripts/jumpterm.sh alacritty alacritty_ranger ranger --selectfile ~/Downloads/nik.md
# i3-msg '[class="alacritty_ranger"] scratchpad show; move position center'

ranger --selectfile "$1"
