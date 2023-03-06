cd $HOME # go to home folder

sudo apt-get update -y

# ===========================
# create common folders
# -------------
mkdir -p DATA
mkdir -p UNPROCESSED
mkdir -p work 

sudo apt install git -y

# ===========================
# fetch all
# -------------

if [ -f $HOME/work/setup ];
then
    echo "setup repository already clone"
else
    cd work
    git clone https://github.com/yzerlaut/setup
    cd ..
fi

# ===========================
# set up neovim
# -------------

echo 'set up neovim ? y/[n]'
read yes_no
if [ "$yes_no" == 'y' ]
then
    mkdir -p .config 
    mkdir -p .config/nvim

    echo "source $HOME/work/setup/init.vim" > ~/.config/nvim/init.vim

    sudo apt install neovim
    sudo apt install xclip # for copy-paste
    sudo apt install curl -y
    # install plugin manager
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

# ===========================
# set up jupyter + neovim
# -------------

echo 'set up jupyter + neovim ? y/[n]'
read yes_no
if [ "$yes_no" == 'y' ]
then
    conda install jupyter
    pip install neovim 
    cp $HOME/work/setup/python/jupyter_qtconsole_config.py $HOME/.jupyter/
fi

# ===========================
# set up time 
# -------------

echo 'set up time info to Europe/Paris ? y/[n]'
read yes_no
if [ "$yes_no" == 'y' ]
then
    sudo timedatectl set-timezone Europe/Paris -y
fi


# ===========================
# configure git
# -------------

echo 'Do you want to install and configure git ? y/[n]'
read yes_no
if [ "$yes_no" == 'y' ]
then
    echo "git settings >>  yann.zerlaut@gmail.com ; Yann Zerlaut"
    git config --global user.email "yann.zerlaut@gmail.com"
    git config --global user.name "Yann Zerlaut"
fi

# ===========================
# configure ssh
# -------------

echo 'Do you want to configure the ssh-agent and generate a new ssh key ? y/[n]'
read yes_no
if [ "$yes_no" == 'y' ]
then 
    ssh-keygen -t rsa -b 4096 -C "yann.zerlaut@gmail.com"
    eval "$(ssh-agent -s)"
    ssh-add -K $HOME/.ssh/id_rsa
    cat $HOME/.ssh/id_rsa.pub
    read -p "[...] =========== >> Copy the following key in the list of github ssh keys [Press anykey to continue]" none
fi

# ===========================
# Cloning the common modules repository
# -------------
echo 'Do you need to clone the analyz/datavyz/finalyz repositories ? y/[n]'
read yes_no
if [ "$yes_no" == 'y' ]
then
    cd work
    git clone https://github.com/yzerlaut/analyz.git
    git clone https://github.com/yzerlaut/datavyz.git
    git clone https://github.com/yzerlaut/finalyz.git
    cd $HOME
fi

# ===========================
# bash profile
# -------------
echo 'Do you want to update your bash profile? y/[n]'
read yes_no
if [ "$yes_no" == 'y' ]
then
    printf "source $HOME/work/setup/bash/profile.sh\n" >> $HOME/.bashrc
fi

# ===========================
# install emacs
# -------------
echo 'Do you want to install emacs ? y/[n]'
read yes_no
if [ "$yes_no" == 'y' ]
then 
    #install emacs
    echo "[...] installing emacs"
    # sudo add-apt-repository ppa:kelleyk/emacs
    # sudo apt-get update
    sudo apt-get install emacs -y
fi

# ===========================
# .emacs
# -------------
echo 'Do you want to update your .emacs ? y/[n]'
read yes_no
if [ "$yes_no" == 'y' ]
then
    cp $HOME/work/common_libraries/setup_tools/dot_emacs $HOME/.emacs
    echo ' --> Need to install the following packages in EMACS: "material-theme", "auto-complete", "ein" '
fi

# ===========================
# LaTeX
# -------------
echo 'Do you need to install LaTeX [BASE] ? y/[n]'
read yes_no
if [ "$yes_no" == 'y' ]
then 
    sudo apt-get install texlive-base -y
fi

echo 'Do you need to install LaTeX [FULL] ? y/[n]'
read yes_no
if [ "$yes_no" == 'y' ]
then 
    sudo apt-get install texlive-full -y
fi

# ===========================
# Inkscape
# -------------
echo 'Do you need to install Inkscape ? y/[n]'
read yes_no
if [ "$yes_no" == 'y' ]
then 
    sudo add-apt-repository universe -y
    sudo add-apt-repository ppa:inkscape.dev/stable -y
    sudo apt install inkscape -y
fi

# ===========================
# ImageJ
# -------------
echo 'Do you need to install ImageJ ? y/[n]'
read yes_no
if [ "$yes_no" == 'y' ]
then 
    wget https://wsr.imagej.net/distros/linux/ij153-linux64-java8.zip
    unzip -x ij153-linux64-java8.zip -d ~/
fi

# ===========================
# Other
# -------------
# ===========================
# .emacs
# -------------

echo 'Do you want to set up the Compose Key as the Caps-Lock key ?'
read yes_no
if [ "$yes_no" == 'y' ]
then 
    cp $HOME/work/common_libraries/setup_tools/dot_Xmodmap $HOME/.Xmodmap
    xmodmap $HOME/.Xmodmap
fi

echo 'Do you need to install Gnome Tweaks (for compose key) ? y/[n]'
read yes_no
if [ "$yes_no" == 'y' ]
then 
    sudo apt install gnome-tweaks -y
fi

echo 'Do you need to install KolourPaint ? y/[n]'
read yes_no
if [ "$yes_no" == 'y' ]
then 
    sudo apt install kolourpaint -y
fi


echo 'Do you need thunderbird ? y/[n]'
read yes_no
if [ "$yes_no" == 'y' ]
then 
    sudo snap install thunderbird -y
fi

echo 'Do you need audacity ? y/[n]'
read yes_no
if [ "$yes_no" == 'y' ]
then 
    sudo snap install audacity -y
fi

echo 'Do you need jabref ? y/[n]'
read yes_no
if [ "$yes_no" == 'y' ]
then 
    sudo snap install jabref -y
fi
