#!/usr/bin/env bash

# TODO: не работает сука; connection refused либо ничего вобще в полибаре не показывает

# Alias
FIFO_PATH="/run/user/$UID/sxhkd.fifo"
UNIX_DOMAIN_SOCKET="/run/user/$UID/sxhkd.fifo.sxhkd-statusd"

killall -v sxhkd-statusd
killall -v socat
killall -v sxhkd
while pgrep -u $UID -x sxhkd >/dev/null; do sleep 1; done

# Reset fifo
[ -e "$FIFO_PATH" ] && rm "$FIFO_PATH"
[ -e "$UNIX_DOMAIN_SOCKET" ] && rm "$UNIX_DOMAIN_SOCKET"
mkfifo "$FIFO_PATH"

# Launch sxhkd
sxhkd -s "$FIFO_PATH" &

# Run sxhkd-statusd with the sxhkd status pipe
~/.config/scripts/bin/sxhkd-statusd /run/user/$UID/sxhkd.fifo &

# TODO: and I reset the sxhkd when launching the polybar
