#!/bin/zsh
# ,---- [ ]
# | 
# | $1 vpn-connection-name
# | $2 up/down
# |  
# `----

nmcli connection $2 $1 | while read OUTPUT; do notify-send "$OUTPUT"; done

# nmcli connection up sanjuan_oficina