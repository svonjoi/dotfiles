#!/bin/bash
# NOTE: если дроченый клауд не монтируется, запустить этот скрипт вручную еще раз (сначала размонтировать)

set -x

# prepare directories
declare -a directories=(
    "~/gdrive/gdrive_loadmaks/"
)

for dir in "${directories[@]}"; do
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
    fi
done

# set up the environment variables needed to use opam
eval $(opam env)

# первый раз надо засетапить
# google-drive-ocamlfuse -label gdrive-loadmaks -id XXX -secret XXX ~/gdrive/gdrive_loadmaks

google-drive-ocamlfuse -label gdrive-loadmaks ~/gdrive/gdrive_loadmaks

# TODO: эта дрочь не работает, если запускается со скрипта
# а если вручную то сразу ебашит; тестануть в след раз с `set -x`
#
# mount | grep /mnt/gdrive_ >/dev/null || google-drive-ocamlfuse -label gdrive_loadmaks /mnt/gdrive_loadmaks/
