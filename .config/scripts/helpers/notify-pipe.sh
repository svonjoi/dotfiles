#!/usr/bin/env sh

read notification

if [[ ! "$notification" ]]; then
	exit 1
fi

notify-send "notify-pipe" "$notification" "$@"
