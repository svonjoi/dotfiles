#!/usr/bin/env sh

set -eu
realpath "$@" |
	perl -lne 'print unless -z # to avoid apps failing because they can not determine a filetype of empty file' |
	sed 's@^@file://@' |
	xclip -selection clipboard -t text/uri-list
