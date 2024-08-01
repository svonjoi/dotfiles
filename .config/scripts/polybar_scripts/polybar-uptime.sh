#!/bin/zsh

# days="$($HOME/.config/scripts/uptime_seconds.sh) / 86400" | bc
seconds="$($HOME/.config/scripts/uptime_seconds.sh)"
days=$(echo "$seconds / 86400" | bc)
echo "$days"

