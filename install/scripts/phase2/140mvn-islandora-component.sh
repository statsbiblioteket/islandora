#!/bin/bash
echo "Installing Islandora Component to Maven"

HOME_DIR=$1
if [ -f "$HOME_DIR/islandora/install/configs/variables" ]; then
  . "$HOME_DIR"/islandora/install/configs/variables
fi


set -e
if [ -f ~/mvn-islandora-component ]; then
    exit
fi
# Chown everything over to the vagrant user just in case
chown -R ${FRONTEND_USER}:${FRONTEND_USER} "$HOME_DIR/.m2"

cd "$HOME_DIR"/islandora/camel/component

sudo -u ${FRONTEND_USER} mvn -q clean install

touch ~/mvn-islandora-component