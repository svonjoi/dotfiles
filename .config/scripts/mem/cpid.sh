#!/bin/zsh

set -eu

printf %s\\n "$@"
ps --no-headers -opid --ppid "$*" | perl -aE 'say $F[0]' | xargs -r "$0"
