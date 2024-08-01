#!/bin/sh

v="${COLOR_PRIMARY}"

vpn="$(nmcli -t -f name,type connection show --order name --active 2>/dev/null | grep vpn | head -1 | cut -d ':' -f 1)"

if [ -n "$vpn" ]; then
	echo " %{F${v}}$vpn%{F-}"
else
	# echo " down"
	echo ""
fi

