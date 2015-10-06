#!/bin/bash
echo "Installing ActiveMQ"

HOME_DIR=$1
if [ -f "$HOME_DIR/islandora/install/configs/variables" ]; then
  . "$HOME_DIR"/islandora/install/configs/variables
fi

"$KARAF_CLIENT" -b < "$KARAF_CONFIGS/activemq.script"
