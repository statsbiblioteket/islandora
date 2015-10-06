#!/bin/bash
echo "Installing Hawtio"

HOME_DIR=$1

if [ -f "$HOME_DIR/islandora/install/configs/variables" ]; then
  . "$HOME_DIR"/islandora/install/configs/variables
fi

"$KARAF_CLIENT" -b < "$KARAF_CONFIGS/hawtio.script"
