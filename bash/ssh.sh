# laptop
laptop_path="/home/yann.zerlaut"
laptop_address="yann.zerlaut@UMR-REBOL-LP001.icm-institute.org"

# work desktop
desktop_path="/home/yann.zerlaut"
desktop_drive_path="/media/yann.zerlaut/DATADRIVE1/"
desktop_address="yann.zerlaut@ICM-REBOL-LF001.icm-institute.org"

# local 1
local1_path="/home/yann.zerlaut"
local1_address="yann.zerlaut@10.0.0.1"

# local 2
local2_path="/home/yann.zerlaut"
local2_address="yann.zerlaut@10.0.0.2"

# ICM desktop 2
desktop2_path="/home/yann.zerlaut"
desktop2_address="yann.zerlaut@UMR-REBOL-LF001.icm-institute.org"

# server adresses
server_address="yann.zerlaut@login02.icm-institute.org"
server_path="/network/lustre/iss02/home/yann.zerlaut"

# other adresses
CaSetup_address="yann@192.168.24.166" # TO BE CHANGED
VisualSetup_address="yann@192.168.17.11" # TO BE CHANGED


pick_location() {
    current_dir=$(pwd)
    
    if [[ ! -z "$SSHPASS" ]]; then
	case $1 in
	    laptop)
		target_address="${laptop_address}"
		target_dir="${current_dir/$starting_path/$laptop_path}"
		;;
	    desktop)
		target_address="${desktop_address}"
		target_dir="${current_dir/$starting_path/$desktop_path}"
		;;
	    local1)
		target_address="${local1_address}"
		target_dir="${current_dir/$starting_path/$local1_path}"
		;;
	    local2)
		target_address="${local2_address}"
		target_dir="${current_dir/$starting_path/$local2_path}"
		;;
	    desktop2)
		target_address="${desktop2_address}"
		target_dir="${current_dir/$starting_path/$desktop2_path}"
		;;
	    desktop_drive)
		target_address="${desktop_address}"
		target_dir="${current_dir/$starting_path/$desktop_drive_path}"
		;;
	    server)
		target_address="${server_address}"
		target_dir="${current_dir/$starting_path/$server_path}"
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
    else
	echo " -----------------------------------------"
	echo " SSHPASS environment variable is not set !"
	echo " set it with: SSHPASS='your_ssh_password' "
	echo " -----------------------------------------"
	target_address=""
	target_dir=""
    fi
}

go_to() {
    pick_location $1
    if [[ ! -z "$target_address" ]]; then
	sshpass -p $SSHPASS ssh -t $target_address "source ~/.bashrc; cd $target_dir ; bash"
    fi
}

rsync_to() {
    pick_location $1
    if [[ ! -z "$target_address" ]]; then
	#sshpass -p $SSHPASS rsync -avhP "$2"/* $target_address:$target_dir/"$2"
    sshpass -p $SSHPASS rsync -avhP ./* $target_address:$target_dir/
    fi
}

rsync_from() {
    pick_location $1
    if [[ ! -z "$target_address" ]]; then
	sshpass -p $SSHPASS rsync -avhP $target_address:$target_dir/* .
    fi
}

copydir_to() {
    pick_location $1
    if [[ ! -z "$target_address" ]]; then
 	echo sshpass -p $SSHPASS scp -r "$2" $target_address:$target_dir/"$2"
 	sshpass -p $SSHPASS scp -r "$2" $target_address:$target_dir/"$2"
    fi
}

copy_to() {
    pick_location $1
    if [[ ! -z "$target_address" ]]; then
 	sshpass -p $SSHPASS scp "$2" $target_address:$target_dir/"$2"
    fi
}

copydir_from() {
    pick_location $1
    if [[ ! -z "$target_address" ]]; then
 	echo sshpass -p $SSHPASS scp -r $target_address:$target_dir/"$2" "$2"
 	sshpass -p $SSHPASS scp -r $target_address:$target_dir/"$2" "$2"
    fi
}


copy_from() {
    pick_location $1
    if [[ ! -z "$target_address" ]]; then
 	sshpass -p $SSHPASS scp $target_address:$target_dir/"$2" "$2"
    fi
}

pull_on() {
    pick_location $1
    if [[ ! -z "$target_address" ]]; then
	sshpass -p $SSHPASS ssh $target_address -t "source ~/.bashrc ; cd $target_dir ; git pull"
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
	sshpass -p $SSHPASS ssh $target_address -t "source ~/.bashrc ; cd $target_dir ; "$COMMAND
    fi
}

create_screen_on() {
    pick_location $1
    if [[ ! -z "$target_address" ]]; then
	sshpass -p $SSHPASS ssh -t $target_address "source ~/.bashrc ; cd $target_dir ; screen -S "$2
    fi
}

list_screen_on() {
    pick_location $1
    if [[ ! -z "$target_address" ]]; then
	sshpass -p $SSHPASS ssh -t $target_address "source ~/.bashrc ;screen -ls;exit"
    fi
}

connect_screen_on() {
    pick_location $1
    if [[ ! -z "$target_address" ]]; then
	sshpass -p $SSHPASS ssh -t $target_address "screen -r "$2
    fi
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
