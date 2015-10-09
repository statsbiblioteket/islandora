#!/bin/bash
echo "Installing Hawtio in Karaf"

HOME_DIR=$1

if [ -f "$HOME_DIR/islandora/install/configs/variables" ]; then
  . "$HOME_DIR"/islandora/install/configs/variables
fi


set -e
if [ -f ~/hawtio ]; then
    exit
fi

"$KARAF_CLIENT" < "$KARAF_CONFIGS/hawtio.script" > /dev/null

touch ~/hawtio