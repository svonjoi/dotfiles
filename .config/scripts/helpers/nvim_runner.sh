#!/bin/zsh
# ,---- [nvim runner]
# | $1 <nvim_config_dir>
# `----

# вывел запуск в отдельный скрипт, таким образом
# зеллиж должен правильно ресарректить сессию неовима

# nvim подгружает конфиг ~/.local/share/$NVIM_APPNAME
NVIM_APPNAME=$1 nvim
