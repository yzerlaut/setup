local_desktop='yann.zerlaut@10.0.0.1:/home/yann.zerlaut'
icm_desktop='yann.zerlaut@ICM-REBOL-LF0001:/home/yann.zerlaut'
local_laptop='yann@10.0.0.2:/home/yann'
nas='yann@10.100.233.33:/volume1/Yann'

backup() {
    echo ""
    echo "available commands for backup:"
    echo ""
    echo "  - backup_documents_desktop_to_drive"
    echo "  - backup_to_nas (source) (target) "
    echo "               e.g. > $ backup_to_nas TSeries-001 CB1/V1/  (writes /Yann/CB1/V1/TSeries-001)"
    echo "               e.g. > $ backup_to_nas V2-data CB1/ "
    echo ""
    echo "  - backup_pdf_library_from_desktop_local (from 10.0.0.1)"
    echo "  - backup_documents_from_desktop_local (from 10.0.0.1)"
    echo "  - backup_pdf_library_to_laptop_local (to 10.0.0.2)"
    echo "  - backup_documents_to_laptop_local (to 10.0.0.2)"
    echo ""
}

backup_documents_desktop_to_drive() {
    echo ""
    echo "running the following command:"
    echo rsync -avhP --stats --dry-run /home/$USER/Documents/* /media/$USER/DATADRIVE1/Yann_Backup/Documents
    rsync -avhP --stats /home/yann.zerlaut/Documents/* /media/yann.zerlaut/DATADRIVE1/Yann_Backup/Documents/
}
    
backup_to_nas() {
    echo ""
    echo "running the following command:"
    echo sshpass -p PASSWORD rsync -avhP --stats --exclude '*.tolarge' $1 $nas/$2
    echo ""
    # echo "type your password:"
    # read pwd
    # sshpass -p $pwd rsync -avhP --stats $1 $nas/$2
}

backup_documents_from_desktop_local() {
    echo ""
    echo "running the following command:"
    echo rsync -avhP --stats --dry-run $local_desktop/Documents/* $HOME/Documents/
    echo "type your password:"
    read pwd
    echo sshpass -p $pwd rsync -avhP --stats --dry-run $local_desktop/Documents/* $HOME/Documents/
}

backup_documents_from_laptop_local() {
    # echo "type your password:\n"
    # read pwd
    echo sshpass -p $1 rsync -avhP --stats --dry-run $local_desktop/Documents/* $HOME/Documents/
}


backup_pdf_library_from_desktop_local() {
    # echo "type your password:\n"
    # read pwd
    echo sshpass -p $1 rsync -avhP --stats --dry-run $local_desktop/Documents/pdf_library/* $HOME/Documents/pdf_library/
}


backup_pdf_library_from_laptop_local() {
    # echo "type your password:\n"
    # read pwd
    echo sshpass -p $1 rsync -avhP --stats --dry-run $local_desktop/Documents/pdf_library/* $HOME/Documents/pdf_library/
}
