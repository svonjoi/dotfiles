#!/bin/bash

# +------------------------------------------------+
# |                  MOUNT CLOUDS                  |
# +------------------------------------------------+
# если дроченый клауд не монтируется, запустить этот скрипт вручную еще раз

# prepare directories
declare -a directories=(
  "/mnt/gdrive_loadmaks/"
)

for dir in "${directories[@]}"; do
  if [ ! -d "$dir" ]; then
    mkdir "$dir"
  fi
done

# set up the environment variables needed to use opam
eval $(opam env)

# TODO: эта дрочь (?иногда) не работает, если запускается со скрипта
# а если вручную то сразу ебашит; тестануть в след раз с `set -x`
mount | grep /mnt/gdrive_ >/dev/null || google-drive-ocamlfuse -label gdrive_loadmaks /mnt/gdrive_loadmaks/

# google-drive-ocamlfuse -label gdrive_loadmaks /mnt/gdrive_loadmaks/
# google-drive-ocamlfuse -label gdrive_svonjoi /mnt/gdrive_svonjoi/
# google-drive-ocamlfuse -label gdrive_inna /mnt/gdrive_inna/
