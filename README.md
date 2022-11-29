# quick setup

> Instructions for a quick setup of new systems under different platforms

## Get python

Install a miniconda distribution:

https://docs.conda.io/en/latest/miniconda.html#latest-miniconda-installer-links

## Linux (debian-based)

### Bash settings

Add to you `~/.bashrc` file the following line:

```
source /home/yann.zerlaut/work/setup/bash/profile.sh
```

### Keyboard / Compose Key

```
keycode 66 = Multi_key                                                                                                                                                                        
clear Lock  
```


## Windows 

### Install `git`

```
conda install -c anaconda git
```

### Install `Vim`

- https://www.vim.org/download.php#pc

## OSX

...

## GIT setup

- Create Token for this new system from the web interface: https://github.com/settings/tokens

Then install and run the github command line interface too to add this token:
```
conda install gh
gh auth login
```

## VIM setup

First clone the plugin manager on your home directory
```
git clone https://github.com/VundleVim/Vundle.vim.git .vim/bundle/Vundle.vim
```

Then add the [./dot_vimrc](./dot_vimrc) file in your home directory and run vim.


