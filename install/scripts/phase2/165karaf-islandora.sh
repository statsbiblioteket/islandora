#!/bin/bash
echo "Installing Islandora * from Maven to Karaf"

HOME_DIR=$1
if [ -f "$HOME_DIR/islandora/install/configs/variables" ]; then
  . "$HOME_DIR"/islandora/install/configs/variables
fi


set -e
if [ -f ~/karaf-islandora ]; then
    exit
fi

# Chown everything over to the vagrant user just in case
chown -R ${FRONTEND_USER}:${FRONTEND_USER} "$HOME_DIR/.m2"

cd "$HOME_DIR"/islandora/camel/karaf

sudo -u ${FRONTEND_USER} mvn -q clean install

"$KARAF_CLIENT" < "$KARAF_CONFIGS/islandora.script" > /dev/null

touch ~/karaf-islandora