#!/bin/bash

# get the path to this script
INST_PATH="`dirname \"$0\"`"              # relative
INST_PATH="`( cd \"$INST_PATH\" && pwd )`"  # absolutized and normalized
echo "Path to this installation script $INST_PATH"

# update package list 
sudo apt -y update

# install git
sudo apt -y install git

# install curl sudo apt -y install curl 
# set RTC to local due to windows compatibility
#timedatectl set-local-rtc 1

# ----- vim ----- 
# install vim
sudo apt -y install vim
# set vim as default editor
# echo "export VISUAL=vim" >> ~/.bashrc
# echo "export EDITOR="$VISUAL"" >> ~/.bashrc
# set vim as default editor for visudo
# sudo echo "Defaults        editor=/usr/bin/vim" >> /etc/sudoers

# install plugin manager for vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
#vim -c 'PlugInstall --sync' -cqa

# download jellybean colorscheme
curl -fLo ~/.vim/colors/jellybeans.vim --create-dirs \
    https://raw.githubusercontent.com/nanotech/jellybeans.vim/master/colors/jellybeans.vim

ln -s $INST_PATH/dotvimrc ~/.vimrc

# ----- pip -----
sudo apt -y install python-pip

# ----- terminator -----
sudo apt -y install terminator

# ----- tmux -----
sudo apt -y install tmux

# ----- ROS ----- 
read -p "Install ROS? [y/n]: " -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # Installation according http://wiki.ros.org/melodic/Installation/Ubuntu
    
    # Setup your sources.list    
    sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
 
    # Set up your keys
    sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
    
    # update package list 
    sudo apt -y update
    
    # Install ROS
    sudo apt -y install ros-melodic-desktop-full # Desktop-Full Install
    #sudo apt install ros-melodic-desktop # Desktop Install
    #sudo apt install ros-melodic-ros-base # ROS-Base: (Bare Bones) 

    # Initialize rosdep
    sudo rosdep init
    sudo rosdep fix-permissions
    rosdep update

    # Environment setup
    if ! grep -q "source /opt/ros/melodic/setup.bash" ~/.bashrc
    then
        echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
        source ~/.bashrc
    fi

    # Dependencies for building packages
    sudo apt -y install python-rosinstall python-rosinstall-generator python-wstool build-essential
fi
