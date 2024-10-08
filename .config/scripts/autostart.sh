~/.config/scripts/hardware/setup_hw.sh

# disable power-button
# https://unix.stackexchange.com/questions/547582/how-to-disable-cleanly-the-power-button
nohup systemd-inhibit \
  --what="handle-power-key" \
  --who="disable-shutdown-button script" \
  --why="allows i3 to open shutdown-dialog instead" \
  sleep 1000d

# set keybinding
# killall sxhkd && setsid -f sxhkd
setsid -f sxhkd

nohup udiskie --tray &
nohup greenclip daemon &
#todo: start crow

# kill this shit: sudo killall teamviewerd
# хуйня проситб пароль заебала
# teamviewer --daemon start

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
mount | grep /mnt/gdrive_ >/dev/null || google-drive-ocamlfuse -label gdrive_loadmaks /mnt/gdrive_loadmaks/

# google-drive-ocamlfuse -label gdrive_loadmaks /mnt/gdrive_loadmaks/
# google-drive-ocamlfuse -label gdrive_svonjoi /mnt/gdrive_svonjoi/
# google-drive-ocamlfuse -label gdrive_inna /mnt/gdrive_inna/
