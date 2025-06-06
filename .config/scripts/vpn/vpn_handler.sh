#!/bin/zsh
# ,---- [vpn-handler]
# | $1 up/down
# | $2 vpn-connection-name: hdt/sanjuan
# `----

# nmcli connection up <con_name>
nmcli connection $1 $2 | while read OUTPUT; do notify-send "$OUTPUT"; done

