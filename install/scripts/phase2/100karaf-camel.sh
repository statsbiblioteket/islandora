#!/bin/bash
echo "Installing Camel in Karaf"

HOME_DIR=$1
if [ -f "$HOME_DIR/islandora/install/configs/variables" ]; then
  . "$HOME_DIR"/islandora/install/configs/variables
fi



set -e
if [ -f ~/camel ]; then
    exit
fi
"$KARAF_CLIENT" < "$KARAF_CONFIGS/camel.script" > /dev/null

touch ~/camel