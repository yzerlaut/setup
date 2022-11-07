########################################
########### bibliography program #######
########################################
#alias biblio='python -m biblio'


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
