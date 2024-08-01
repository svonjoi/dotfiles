#!/usr/bin/env bash
set -exuo pipefail
declare -A progs
for prog in rofi xargs cut firefox; do
	progs[$prog]="$(which $prog)"
done
progs[marks]="$(which marks.pl)"
for input in *.in; do
	sed -E $input \
		$(for prog in ${!progs[@]}; do
			printf -- '-e s|\\b%s\\b|%s|g\n' $prog ${progs[$prog]}
		done) \
		> "${input/%.in}"
	done
