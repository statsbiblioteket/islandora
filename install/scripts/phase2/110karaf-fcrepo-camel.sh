#!/bin/bash
echo "Installing fcrepo-camel in Karaf"

HOME_DIR=$1
if [ -f "$HOME_DIR/islandora/install/configs/variables" ]; then
  . "$HOME_DIR"/islandora/install/configs/variables
fi


set -e
if [ -f ~/karaf-fcrepo-camel ]; then
    exit
fi

"$KARAF_CLIENT" < "$KARAF_CONFIGS/fcrepo-camel.script" > /dev/null

touch ~/karaf-fcrepo-camel