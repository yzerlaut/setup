# quick setup

> Instructions for a quick setup of new systems under different platforms

## Python

Install a miniconda distribution:

https://docs.conda.io/en/latest/miniconda.html#latest-miniconda-installer-links

## Linux (debian-based)

### 1. Get and Install python

Install a miniconda distribution:

https://docs.conda.io/en/latest/miniconda.html#latest-miniconda-installer-links

```
bash whatever-your-anaconda-installer-is.sh
```
accept all defaults (e.g. update .bashrc)


### 2. Run the Setup script !

```
bash ~/work/setup/tools/debian_setup.py
```

Some of the things done, this sets up:
- some ssh shortcuts
- set up the `vi` mode in the shell: `set -o vi`
- set up `vim` as the default editor
- ...
- 

### 3. Some settings

- use `gnome-disks` to automount partitions
- ...

## Windows 

### Install `git`

```
conda install -c anaconda git
```

### Install `Vim`

- https://www.vim.org/download.php#pc

## OSX

### Install `sshpass`

```
brew install hudochenkov/sshpass/sshpass
```
...

### Install XQuartz for X11 forwarding

From: https://www.xquartz.org/

## GIT setup

- Create Token for this new system from the web interface: https://github.com/settings/tokens

Then install and run the github command line interface too to add this token:
```
conda install gh -c conda-forge
gh auth login
```

## `NeoVim` + `jupyter qtconsole` setup: `qvim`

```
sudo apt install neovim
sudo apt install xclip # for copy-paste
pip install neovim 
cp $HOME/work/setup/python/jupyter_qtconsole_config.py $HOME/.jupyter/
```

### Install NeoVim Plugin Manager

```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

## VIM setup

### Plugin Manager
First clone the plugin manager on your home directory
```
git clone https://github.com/VundleVim/Vundle.vim.git .vim/bundle/Vundle.vim
```

Then add the [./dot_vimrc](./dot_vimrc) file in your home directory and run vim.

# Miscellaneous

## slow ssh connection

- edit `/etc/ssh/sshd_config`, and set `UseDNS no` ().
    also potentially:
    ```
    ChallengeResponseAuthentication no
    KerberosAuthentication no
    GSSAPIAuthentication no
    ```
- edit `/etc/nsswitch.conf`, and change this line:
    ```
    hosts:          files mdns4_minimal [NOTFOUND=return] dnsA
    ```
    to:
    ```
    hosts:          files dns
    ```

taken from [https://jrs-s.net/2017/07/01/slow-ssh-logins/](jrs-s.net), see more details there.

## slow login fix 
```
sudo systemctl mask NetworkManager-wait-online.service
```

