#!/bin/bash

echo "running 010bootstrap.sh"

HOME_DIR=$1

. "$HOME_DIR"/islandora/install/configs/variables


if [ ! -d "$DOWNLOAD_DIR" ]; then
  mkdir -p "$DOWNLOAD_DIR"
fi

cd "$HOME_DIR"

sed -i -e '1i\deb mirror://mirrors.ubuntu.com/mirrors.txt trusty main restricted universe multiverse' /etc/apt/sources.list
sed -i -e '1i\deb mirror://mirrors.ubuntu.com/mirrors.txt trusty-backports main restricted universe multiverse' /etc/apt/sources.list
sed -i -e '1i\deb mirror://mirrors.ubuntu.com/mirrors.txt trusty-updates main restricted universe multiverse' /etc/apt/sources.list
sed -i -e '1i\deb mirror://mirrors.ubuntu.com/mirrors.txt trusty-security main restricted universe multiverse' /etc/apt/sources.list


#Make perl shut up about locales
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
locale-gen en_US.UTF-8  >/dev/null
dpkg-reconfigure locales >/dev/null



# Update
apt-get -qq -y update #&& apt-get -y upgrade

# Build tools
apt-get -qq -y install build-essential | grep 'Setting up' | cat

# Git vim
apt-get -qq -y install git vim | grep 'Setting up' | cat

# Wget and curl
apt-get -qq -y install wget curl | grep 'Setting up' | cat

# More helpful packages
apt-get -qq -y install htop tree fish | grep 'Setting up' | cat
