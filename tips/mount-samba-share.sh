# mount the samba share
gio mount smb://iss/rebola
# you can get info on the "local path" with: gio info smb://iss/rebola
# then refresh the UI
killall gfvsd
nemo -q
nemo
