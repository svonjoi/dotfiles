~/bin/hardware/setup_hw.sh

# set keybinding
# killall sxhkd && setsid -f sxhkd
setsid -f sxhkd

nohup udiskie --tray &
nohup greenclip daemon &
#todo: start crow

# Mount clouds
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
mount | grep /mnt/gdrive_ >/dev/null || google-drive-ocamlfuse -label gdrive_loadmaks /mnt/gdrive_loadmaks/

# google-drive-ocamlfuse -label gdrive_loadmaks /mnt/gdrive_loadmaks/
# google-drive-ocamlfuse -label gdrive_svonjoi /mnt/gdrive_svonjoi/
# google-drive-ocamlfuse -label gdrive_inna /mnt/gdrive_inna/

