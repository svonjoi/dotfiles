#!/usr/bin/env bash

case $1 in
get)
	~/.config/scripts/bookmarks/marks.pl get |
		rofi -dmenu -i |
		cut -f 1 |
		xargs printf "open -tr %s" >"$QUTE_FIFO"
	;;
add)
	~/.config/scripts/bookmarks/marks.pl tags |
		rofi -dmenu -i -multi-select |
		xargs ~/.config/scripts/bookmarks/marks.pl add "$QUTE_URL"
	;;
delete)
	~/.config/scripts/bookmarks/marks.pl get |
		rofi -dmenu -i -multi-select |
		cut -f 3 |
		xargs -r ~/.config/scripts/bookmarks/marks.pl del
	;;
esac
