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
# эта дрочь просит пароль судо
# teamviewer --daemon start

# +------------------------------------------------+
# |                  MOUNT CLOUDS                  |
# +------------------------------------------------+

# set up the environment variables needed to use opam
eval $(opam env)

# create dirs if not exist
declare -a directories=(
  "/mnt/gdrive_loadmaks/"
)

for dir in "${directories[@]}"; do
  if [ ! -d "$dir" ]; then
    mkdir "$dir"
  fi
done

# mount if not mounted already
# mount | grep /mnt/gdrive_ >/dev/null || google-drive-ocamlfuse -label gdrive_svonjoi /mnt/gdrive_svonjoi/
# mount | grep /mnt/gdrive_ >/dev/null || google-drive-ocamlfuse -label gdrive_inna /mnt/gdrive_inna/

# TODO: эта дрочь (?иногда) не работает, если запускается со скрипта
mount | grep /mnt/gdrive_ >/dev/null || google-drive-ocamlfuse -label gdrive_loadmaks /mnt/gdrive_loadmaks/

# google-drive-ocamlfuse -label gdrive_loadmaks /mnt/gdrive_loadmaks/
# google-drive-ocamlfuse -label gdrive_svonjoi /mnt/gdrive_svonjoi/
# google-drive-ocamlfuse -label gdrive_inna /mnt/gdrive_inna/
