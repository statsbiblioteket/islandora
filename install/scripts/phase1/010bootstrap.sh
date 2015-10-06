#!/bin/bash

HOME_DIR=$1

if [ -f "$HOME_DIR/islandora/install/configs/variables" ]; then
  . "$HOME_DIR"/islandora/install/configs/variables
fi

if [ ! -d "$DOWNLOAD_DIR" ]; then
  mkdir -p "$DOWNLOAD_DIR"
fi

cd "$HOME_DIR"

sed -i -e '1ideb mirror://mirrors.ubuntu.com/mirrors.txt trusty main restricted universe multiverse\' /etc/apt/sources.list
sed -i -e '1ideb mirror://mirrors.ubuntu.com/mirrors.txt trusty-backports main restricted universe multiverse\' /etc/apt/sources.list
sed -i -e '1ideb mirror://mirrors.ubuntu.com/mirrors.txt trusty-updates main restricted universe multiverse\' /etc/apt/sources.list
sed -i -e '1ideb mirror://mirrors.ubuntu.com/mirrors.txt trusty-security main restricted universe multiverse\' /etc/apt/sources.list

# Set apt-get for non-interactive mode
export DEBIAN_FRONTEND=noninteractive

#Make perl shut up about locales
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
locale-gen en_US.UTF-8
dpkg-reconfigure locales



# Update
apt-get -y update #&& apt-get -y upgrade

# SSH
apt-get -y install openssh-server

# Build tools
apt-get -y install build-essential

# Git vim
apt-get -y install git vim

# Wget and curl
apt-get -y install wget curl

# More helpful packages
apt-get -y install htop tree fish
