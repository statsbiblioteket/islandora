#!/bin/bash
echo "Installing ActiveMQ in Karaf"

HOME_DIR=$1
if [ -f "$HOME_DIR/islandora/install/configs/variables" ]; then
  . "$HOME_DIR"/islandora/install/configs/variables
fi


set -e
if [ -f ~/karaf-activemq ]; then
    exit
fi

"$KARAF_CLIENT" < "$KARAF_CONFIGS/activemq.script" > /dev/null

touch ~/karaf-activemq