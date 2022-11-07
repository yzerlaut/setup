starting_path=$HOME

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

load_config() {
    case "$OSTYPE" in
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
	linux*)
	    alias open="xdg-open"
	    alias em='emacs -nw -q'
	    source $HOME/work/setup/bash/backup.sh
	    source $HOME/work/setup/bash/git.sh
	    source $HOME/work/setup/bash/ssh.sh
	    source $HOME/work/setup/bash/various.sh
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

alias reload=load_config

#xmodmap -e "keysym Caps_Lock = Multi_key"
