#!/bin/bash
echo "Installing Islandora Commands"

HOME_DIR=$1

if [ -f "$HOME_DIR/islandora/install/configs/variables" ]; then
  . "$HOME_DIR"/islandora/install/configs/variables
fi


set -e
if [ -f ~/commands ]; then
    exit
fi

cd "$HOME_DIR"/islandora/camel/commands

curl -sS https://getcomposer.org/installer | php
php composer.phar install

touch ~/commands