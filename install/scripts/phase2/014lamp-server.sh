#!/usr/bin/env bash

HOME_DIR=$1

if [ -f "$HOME_DIR/islandora/install/configs/variables" ]; then
  . "$HOME_DIR"/islandora/install/configs/variables
fi

cd "$HOME_DIR"

# Set apt-get for non-interactive mode
export DEBIAN_FRONTEND=noninteractive

#Make perl shut up about locales
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
locale-gen en_US.UTF-8
dpkg-reconfigure locales


# Set some params so it's non-interactive for the lamp-server install
debconf-set-selections <<< 'mysql-server mysql-server/root_password password islandora'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password islandora'
debconf-set-selections <<< "postfix postfix/mailname string islandora-fedora4.org"
debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Internet Site'"

# Lamp server
tasksel install lamp-server
usermod -a -G www-data ${FRONTEND_USER}

# Get the repo
chown -R ${FRONTEND_USER}:${FRONTEND_USER} $HOME_DIR/islandora

