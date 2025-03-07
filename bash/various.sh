########################################
########### bibliography program #######
########################################
#alias biblio='python -m biblio'

get_my_ip() {
    IP=$(echo $(dig TXT +short o-o.myaddr.l.google.com @ns1.google.com | awk -F'"' '{ print $2}'))
    echo $IP
}

send_my_ip() {
    get_my_ip
    echo "$IP" | mail -s "current IP" yann.zerlaut@proton.me
}

########################################
###########    printing tools    #######
########################################

print_icm() {
    lpr -o media=a4 -P Copieurs_Sharp $1
}

list_printers() {
    lpstat -p | grep '^printer' | awk '{print $2}'
}

########################################

########### external drive tools #######
########################################

format_drive() {
    # requires mkfs and mtools, sudo apt-get install mtools
    lsblk
    echo "---------------------------------------------"
    echo "---> choose the drive to be formatted:"
    echo "       (should be something like: /dev/sdc) :\n"
    read drive
    echo "---> choose the future name of the drive "
    echo " [yann_usb]"
    read name
    if [ "$name" = '' ]
    then 
	name='yann_usb'
    fi
    # confirmation
    echo " /!\ Are you sure that want to format the drive" $drive " ? y/[n]"
    read confirmation
    if [ "$confirmation" = 'y' ]
    then
	echo "formatting the drive [...]"
	umount $drive
	sudo mkfs.vfat -I $drive
	sudo mlabel -i $drive -s ::$name	
	echo "-> done !"
    fi
}
########################################
########### external drive tools #######
########################################

new_song() {
    echo "---------------------------------------------"
    echo "---> Type the Title of the Song:"
    echo "       (should be something like: /dev/sdc) :\n"
    read title 
    echo $title
}
