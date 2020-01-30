#!/bin/bash

# get the path to this script
INST_PATH="`dirname \"$0\"`"              # relative
INST_PATH="`( cd \"$INST_PATH\" && pwd )`"  # absolutized and normalized
echo "Path to this installation script $INST_PATH"

# update package list 
sudo apt -y update

# install git
sudo apt -y install git

# install curl
sudo apt -y install curl

# set RTC to local due to windows compatibility
#timedatectl set-local-rtc 1

# ----- vim ----- 
# install vim
sudo apt -y install vim

# install plugin manager for vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
#vim -c 'PlugInstall --sync' -cqa

# download jellybean colorscheme
curl -fLo ~/.vim/colors/jellybeans.vim --create-dirs \
    https://raw.githubusercontent.com/nanotech/jellybeans.vim/master/colors/jellybeans.vim

ln -s $INST_PATH/dotvimrc ~/.vimrc
