#!/bin/bash
echo "Installing Islandora Services to Maven"

HOME_DIR=$1
if [ -f "$HOME_DIR/islandora/install/configs/variables" ]; then
  . "$HOME_DIR"/islandora/install/configs/variables
fi


set -e
if [ -f ~/mvn-islandora-services ]; then
    exit
fi
# Chown everything over to the vagrant user just in case
chown -R ${FRONTEND_USER}:${FRONTEND_USER} "$HOME_DIR/.m2"

cd "$HOME_DIR"/islandora/camel/services

cd collection-service
sudo -u ${FRONTEND_USER} mvn -q clean install

cd "$HOME_DIR"/islandora/camel/services

cd basic-image-service
sudo -u ${FRONTEND_USER} mvn -q clean install


touch ~/mvn-islandora-services