starting_path=$HOME

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

qvim() {
    jupyter qtconsole --style=zenburn & 
    nvim $1
}

load_config() {
    case "$OSTYPE" in
	linux*)
	    alias open="xdg-open"
	    alias em='emacs -nw -q'
        set -o vi # Set vi for bash editing mode
        EDITOR=vi # Set vi as the default editor for all apps that check this
        source $HOME/work/setup/bash/backup.sh
	    source $HOME/work/setup/bash/git.sh
	    source $HOME/work/setup/bash/ssh.sh
	    source $HOME/work/setup/bash/various.sh
	    ;;
	msys*)
	    alias open="cmd /c start"
	    alias em="/c/Program\ Files/Emacs/x86_64/bin/runemacs.exe -nw -q"
	    alias emacs="/c/Program\ Files/Emacs/x86_64/bin/runemacs.exe"
	    alias inkscape="/c/Program\ Files/Inkscape/bin/inkscape.exe"
	    source $HOME/work/setup/bash/backup.sh
	    source $HOME/work/setup/bash/git.sh
	    source $HOME/work/setup/bash/ssh.sh
	    source $HOME/work/setup/bash/various.sh
	    ;;
	cygwin*)
	    alias open="cmd /c start"
	    ;;
	darwin*)
	    # ---------- INKSCAPE
	    alias inkscape='/Applications/Inkscape.app/Contents/MacOS/Inkscape'
	    # ---------- EMACS
	    alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs'
	    alias em='/Applications/Emacs.app/Contents/MacOS/Emacs -nw -q'
	    source $HOME/work/setup/bash/backup.sh
	    source $HOME/work/setup/bash/git.sh
	    source $HOME/work/setup/bash/ssh.sh
	    source $HOME/work/setup/bash/various.sh
	    ;;
    esac

}
load_config

# to load the 
VIMRCFILE='$HOME/work/setup/init.vim'

# caps-lock for "Compose Key"
#xmodmap -e "keysym Caps_Lock = Multi_key"

# some terminal aliases:
alias reload=load_config
alias physion='cd ~/work/physion/src; conda activate physion'
alias suite2p='conda activate suite2p; python -m suite2p'
