#!/bin/bash
echo "Deploying Islandora config to Karaf"

HOME_DIR=$1
if [ -f "$HOME_DIR/islandora/install/configs/variables" ]; then
  . "$HOME_DIR"/islandora/install/configs/variables
fi

cp "$HOME_DIR"/islandora/camel/sync/src/main/cfg/ca.islandora.sync.cfg /opt/karaf/etc
