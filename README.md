# Quick initial setup

> Instructions for a quick setup of new systems under different platforms


## 1) Install a `python` distribution (through [Miniforge](https://github.com/conda-forge/miniforge))

- MsWin:
    ```
    curl -L -O https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Windows-x86_64.exe
    start /wait "" Miniforge3-Windows-x86_64.exe /InstallationType=JustMe /RegisterPython=1 /S /D=%UserProfile%\Miniforge3 # use as default
    ```

- UNIX (Linux / OSX)
    ```
    curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
    bash Miniforge3-$(uname)-$(uname -m).sh
    ```

## 2) Install basic tools: `vim`, `git`, `git-auth`

```
conda install vim git gh
```

## 3) Clone this repository

```
git clone https://github.com/yzerlaut/setup
```

## 4) Additional softwares

- [Inkscape](https://inkscape.org/): a vector graphics software

- [Tabby](https://github.com/eugeny/tabby): a multi-platform terminal

- ...


# Set up OpenSSH server

#### Unix

[...]

#### MsWin

In the PowerShell (need admin rights):

```
Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH.Server*' | Add-WindowsCapability -Online
```

```
Get-WindowsCapability -Online | ? Name -like 'OpenSSH.Ser*'
```

```
Set-Service -Name sshd -StartupType 'Automatic'
```

```
netstat -na
```

```
Get-NetFirewallRule -Name *OpenSSH-Server* |select Name, DisplayName, Description, Enabled
```

```
New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
```

```
start-process notepad C:\Programdata\ssh\sshd_config
```

[troubleshoot Get-Net* pb](https://superuser.com/questions/1152280/get-net-powershell-cmdlets-failing-with-invalid-class)

#### Configure `sshd_config`

[...]


# OS-specific setup

## Linux (ubuntu/debian-based systems)

#### - Add aliases and shortcuts to your `.profile`

    ```
    source ~/work/setup/bash/profile.sh
    ```
    this adds ssh shortcuts, environment variables, ...

#### - set up the `vi` mode in the shell 
    ```
    set -o vi
    ```

#### set up `vi` as the default editor (ubuntu/debian-based systems):
    ```
    sudo update-alternatives --set editor /usr/bin/vim.basic
    sudo update-alternatives --set vi /usr/bin/vim.basic
    ```

### 2. Some settings

- use `gnome-disks` to automount partitions
- ...


## OSX

- Install XQuartz for X11 forwarding:
    From: https://www.xquartz.org/

## MsWin

[...]

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

