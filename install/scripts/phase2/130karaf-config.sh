#!/bin/bash
echo "Deploying Islandora config to Karaf"

HOME_DIR=$1
if [ -f "$HOME_DIR/islandora/install/configs/variables" ]; then
  . "$HOME_DIR"/islandora/install/configs/variables
fi

cp "$HOME_DIR"/islandora/camel/sync/src/main/cfg/ca.islandora.sync.cfg /opt/karaf/etc
cp "$HOME_DIR"/islandora/camel/services/basic-image-service/src/main/cfg/ca.islandora.services.basic.image.cfg /opt/karaf/etc
cp "$HOME_DIR"/islandora/camel/services/collection-service/src/main/cfg/ca.islandora.services.collection.cfg /opt/karaf/etc