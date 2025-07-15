#!/bin/zsh

v="${POLYCOLOR1}"

# days="$($HOME/.config/scripts/uptime_seconds.sh) / 86400" | bc
seconds="$($HOME/.config/scripts/uptime_seconds.sh)"
days=$(echo "$seconds / 86400" | bc)

# 󰤄󰤆🌙
# echo "%{F${v}}🌙%{F-}*$days"
echo "$days"

