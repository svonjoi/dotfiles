#!/bin/bash
# https://thevaluable.dev/practical-guide-fzf-example/
# https://github.com/junegunn/fzf/wiki/Examples#dnf

FZF_EXPLORER_CMD="find ~/.i3/i3-resurrect/ -type f" &&
  eval $FZF_EXPLORER_CMD | fzf \
    --bind 'enter:unbind(enter)' \
    --bind 'space:execute(rm {})' \
    --bind="space:+reload($FZF_EXPLORER_CMD)" \
    --bind "ctrl-r:reload($FZF_EXPLORER_CMD)" \
    --header='[C-r] обновить сука | [Space] удалить нахуй'
