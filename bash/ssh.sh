# macbook 
macbook_path="/Users/yann" # OSX laptop
macbook_address="yann@10.0.0.2"

# laptop
laptop_path="/home/yann"
laptop_address="yann@10.0.0.2"

# desktop
desktop_path="/home/yann.zerlaut"
desktop_drive_path="/media/yann.zerlaut/DATADRIVE1/"
desktop_address="yann.zerlaut@ICM-REBOL-LF001.icm-institute.org"

# Sofia's desktop
sofias_path="C:\\\\Users\\a.yann.zerlaut"
sofias_address="a.yann.zerlaut@ICM-REBOL-WF009.icm-institute.org"

# local 1
local1_path="/home/yann.zerlaut"
local1_address="yann.zerlaut@10.0.0.1"

# local 2
local2_path="/home/yann"
local2_address="yann@10.0.0.2"

# ICM desktop 2
analysis_path="/home/yann.zerlaut"
analysis_address="yann.zerlaut@UMR-REBOL-LF001.icm-institute.org"

# server adresses
server_address="user@10.0.0.1"
server_path="/home/user"

# NAS adresses
NAS_address="admin@10.100.233.33"
NAS_path="/volume1/Yann"

# NAS1 adresses
NAS1_address="admin@10.0.0.3"
NAS1_path="/volume1/homes/admin"

# NAS2 adresses
NAS2_address="admin@10.0.0.4"
NAS2_path="/volume1/homes/admin"

# local NAS adresses
localNAS_address="yann@10.0.0.3"
localNAS_path="/volume1/Yann"

# other adresses
CaSetup_address="yann@192.168.24.166" # TO BE CHANGED
VisualSetup_address="yann@192.168.17.11" # TO BE CHANGED


pick_location() {
    current_dir=$(pwd)
    
	case $1 in
	    macbook)
		target_address="${macbook_address}"
		target_dir="${current_dir/$starting_path/$macbook_path}"
		;;
	    laptop)
		target_address="${laptop_address}"
		target_dir="${current_dir/$starting_path/$laptop_path}"
		;;
	    desktop)
		target_address="${desktop_address}"
		target_dir="${current_dir/$starting_path/$desktop_path}"
		;;
	    sofias)
		target_address="${sofias_address}"
		target_dir="${current_dir/$starting_path/$sofias_path}"
		;;
	    1)
		target_address="${local1_address}"
		target_dir="${current_dir/$starting_path/$local1_path}"
		;;
	    2)
		target_address="${local2_address}"
		target_dir="${current_dir/$starting_path/$local2_path}"
		;;
	    analysis)
		target_address="${analysis_address}"
		target_dir="${current_dir/$starting_path/$analysis_path}"
		;;
	    desktop_drive)
		target_address="${desktop_address}"
		target_dir="${current_dir/$starting_path/$desktop_drive_path}"
		;;
	    server)
		target_address="${server_address}"
		target_dir="${current_dir/$starting_path/$server_path}"
		;;
	    NAS)
		target_address="${NAS_address}"
		target_dir="${current_dir/$starting_path/$NAS_path}"
        if [[ ! -z "$NASPASS" ]]; then
            SSHPASS=$NASPASS
        fi
		;;
	    localNAS)
		target_address="${localNAS_address}"
		target_dir="${current_dir/$starting_path/$localNAS_path}"
        if [[ ! -z "$NASPASS" ]]; then
            SSHPASS=$NASPASS
        fi
		;;
	    CaSetup)
		target_address="${CaSetup_address}"
		target_dir="${current_dir/$starting_path/$server_path}"
		;;
	    VisualSetup)
		target_address="${VisualSetup_address}"
		target_dir="${current_dir/$starting_path/$server_path}"
		;;
	    *)
		echo $1 'not found'
		;;
	esac
}

go_to() {
    pick_location $1
    if [[ ! -z "$target_address" ]]; then
        if [[ "$target_dir" == *"C:"* ]]; then
            # simple ssh for windows:
            ssh $target_address
        else 
            # otherwise we go to the matching directory
            ssh -t $target_address "cd $target_dir; bash -l"
        fi
    fi
}

work_on() {
    pick_location $1
    if [[ ! -z "$target_address" ]]; then
	ssh -fnXY $target_address 'xterm & xterm & wait'
    fi
}

rsync_to() {
    pick_location $1
    if [[ ! -z "$target_address" ]]; then
	#rsync -avhP "$2"/* $target_address:$target_dir/"$2"
    case "$OSTYPE" in
        darwin*)
            rsync -avhP ./ $target_address:$target_dir/
            ;;
        *)
            rsync -avhP ./* $target_address:$target_dir/
            ;;
    esac
    fi
}

rsync_from() {
    pick_location $1
    if [[ ! -z "$target_address" ]]; then
    case "$OSTYPE" in
        darwin*)
	        rsync -avhP $target_address:$target_dir/ ./
            ;;
        *)
	        rsync -avhP $target_address:$target_dir/* .
            ;;
    esac

    fi
}

copydir_to() {
    pick_location $1
    if [[ ! -z "$target_address" ]]; then
 	echo scp -r "$2" $target_address:$target_dir/"$2"
 	scp -r "$2" $target_address:$target_dir/"$2"
    fi
}

copy_to() {
    pick_location $1
    if [[ ! -z "$target_address" ]]; then
 	scp "$2" $target_address:$target_dir/"$2"
    fi
}

copydir_from() {
    pick_location $1
    if [[ ! -z "$target_address" ]]; then
 	echo scp -r $target_address:$target_dir/"$2" "$2"
 	scp -r $target_address:$target_dir/"$2" "$2"
    fi
}


copy_from() {
    pick_location $1
    if [[ ! -z "$target_address" ]]; then
 	scp $target_address:$target_dir/"$2" "$2"
    fi
}

pull_on() {
    pick_location $1
    if [[ ! -z "$target_address" ]]; then
	ssh $target_address -t "source ~/.bashrc ; cd $target_dir ; git pull"
    fi
}
	
run_on() {
    pick_location $1
    if [[ ! -z "$target_address" ]]; then
	# getting extension and choosing program
	EXTENSION=`echo "$2" | cut -d'.' -f2`
	if [ $EXTENSION == 'py' ]
	then
	    COMMAND='python '$2
	elif [ $EXTENSION == 'sh' ]
	then
	    COMMAND='bash '$2
	fi
	# adding the arguments
	# for var in "$@"
	# do
	# 	COMMAND=$COMMAND" "$var
	# done
	
	echo ssh $target_address -t "source ~/.bashrc ; cd $target_dir ; "$COMMAND
	ssh $target_address -t "source ~/.bashrc ; cd $target_dir ; "$COMMAND
    fi
}

create_screen_on() {
    pick_location $1
    if [[ ! -z "$target_address" ]]; then
	ssh -t $target_address "source ~/.bashrc ; cd $target_dir ; screen -S "$2
    fi
}

list_screen_on() {
    pick_location $1
    if [[ ! -z "$target_address" ]]; then
	ssh -t $target_address "source ~/.bashrc ;screen -ls;exit"
    fi
}

connect_screen_on() {
    pick_location $1
    if [[ ! -z "$target_address" ]]; then
	ssh -t $target_address "screen -r "$2
    fi
}

print_on() {
    # ----------------------------------------------- #
    # Need to have a "Copieurs_Sharp" configured !!
    #       on the target machine              
    # ----------------------------------------------- #
    pick_location $1
    if [[ ! -z "$target_address" ]]; then
        scp $2 ${target_address}:temp
        ssh -t $target_address "lp -d Copieurs_Sharp ~/temp; sleep 3s; rm ~/temp; echo done !"
    fi
}

mount_NAS() {
    echo ""
    echo "create a NAS folder in your home directory:"
    echo "          mkdir ~/NAS .  "
    echo ""
    echo " - from a local connection:"
    echo "     to NAS1 (LAN2)"
    echo "          sshfs -o allow_other,default_permissions admin@10.0.0.3:/ ~/NAS"
    echo "     to NAS2 (LAN1)"
    echo "          sshfs -o allow_other,default_permissions admin@10.0.0.4:/ ~/NAS"
    echo "     to NAS2 (LAN2)"
    echo "          sshfs -o allow_other,default_permissions admin@10.0.0.4:/ ~/NAS"
    echo " - from an ICM network connection:"
    echo "     to NAS1 (LAN1)"
    echo "          sshfs -o allow_other,default_permissions admin@10.100.233.33:/ ~/NAS"
}

##################################################################################
######## deprecated methods ######################################################
##################################################################################

# alias slog="ssh $server_address"
# alias dlog="ssh $desktop_address"
# alias llog="ssh $laptop_address"
# alias slogx="ssh -X $server_address"
# alias dlogx="ssh -X $desktop_address"
# alias cache_cred="git config --global credential.helper 'cache --timeout 31*24*3600'"
# alias load_git="module load git"


# create_screen_with_modules_on_master() {
#     spull # to be sure to have the same version on server !!
#     current_dir=$(pwd)
#     dir_on_server="${current_dir/$HOME/$server_path}"
#     ssh -t $server_address "cd $dir_on_server ; cd data_analysis/ ;  git fetch origin ;  git checkout origin/master ; cd ../ ; cd neural_network_dynamics/ ; git fetch origin ; git checkout origin/master; cd ../ ; cd graphs/ ; git fetch origin ; git checkout origin/master ; cd ../ ; screen -S "$1
# }
# alias sc_master=create_screen_with_modules_on_master

# go_to_mirror_server_dir() {
#     go_to server
#     load_git
# }
# alias sdir=go_to_mirror_server_dir

# go_to_mirror_desktop_dir() {
#     go_to desktop
# }
# alias ddir=go_to_mirror_desktop_dir

# pull_on_desktop() {
#     current_dir=$(pwd)
#     git commit -a -m "[automated commit to synchronize when over ssh]"
#     git push origin master
#     dir_on_desktop="${current_dir/$laptop_path/$desktop_path}"
#     ssh $desktop_address -t "source ~/.bash_profile ; cd $dir_on_desktop ; git pull origin master ; git submodule update --recursive"
# }
# alias dpull=pull_on_desktop

# pull_on_server() {
#     current_dir=$(pwd)
#     git commit -a -m "[automated commit to synchronize when over ssh]"
#     git push origin master
#     dir_on_server="${current_dir/$laptop_path/$server_path}"
#     ssh $server_address -t "source ~/.bashrc ; cd $dir_on_server ; git pull origin master ; git submodule update --recursive"
# }
# alias spull=pull_on_server

# start_notebook() {
#     # go to the current directory given the server path structure
#     current_dir=$(pwd)
#     # then same directory in cluster
#     dir_on_server="${current_dir/$laptop_path/$server_path}"
#     ssh -X $server_address -t "cd $dir_on_server ; source ~/.bashrc ; /home/safaai/anaconda3/bin/jupyter notebook --ip=10.231.128.22 --port=8889"
# }
# alias snb=start_notebook

# run_script_func() {
#     pull_on desktop
#     # getting extension and choosing program
#     EXTENSION=`echo "$1" | cut -d'.' -f2`
#     if [ $EXTENSION == 'py' ]
#     then
# 	COMMAND='python '
#     elif [ $EXTENSION == 'sh' ]
#     then
# 	COMMAND='bash '
#     fi
#     # adding the arguments
#     for var in "$@"
#     do
# 	COMMAND=$COMMAND" "$var
#     done
#     echo $COMMAND
#     current_dir=$(pwd)
#     # then same directory in cluster
#     dir_on_server="${current_dir/$laptop_path/$server_path}"
#     ssh $server_address -t "source ~/.bashrc ; cd $dir_on_server ; "$COMMAND
#     get_data_file_script
# }
# alias srun=run_script_func
