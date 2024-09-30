#!/bin/zsh
# ,---- [vpn-handler]
# | $1 up/down
# | $2 vpn-connection-name: hdt/sanjuan
# `----

# nmcli connection up sanjuan_oficina
nmcli connection $1 $2 | while read OUTPUT; do notify-send "$OUTPUT"; done

