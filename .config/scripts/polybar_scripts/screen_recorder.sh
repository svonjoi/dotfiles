#!/bin/sh

PID_FILE="/tmp/screencast.pid"
SCREENCAST_FILE="/tmp/screencast.mp4"

v="#ff4444"
c=%{F${v}}
nc=%{F-}

day="${c}M${nc}󰧟󰧟󰧟󰧟󰧟󰧟"

if [ -e $PID_FILE ]; then
	echo "${c}REC.${nc}"
else
	echo ""
fi
