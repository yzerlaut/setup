# mount the samba share
gio mount smb://iss/rebola

# then refresh the UI
killall gfvsd
nemo -q
nemo

# you can get info on the "local path" with: 
gio info smb://iss/rebola

# otherwise
smbclient -U yann.zerlaut //iss/rebola
