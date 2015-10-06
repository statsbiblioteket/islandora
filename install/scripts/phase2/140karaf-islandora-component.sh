#!/bin/bash
echo "Installing Islandora Component"

HOME_DIR=$1
if [ -f "$HOME_DIR/islandora/install/configs/variables" ]; then
  . "$HOME_DIR"/islandora/install/configs/variables
fi

# Chown everything over to the vagrant user just in case
chown -R ${FRONTEND_USER}:${FRONTEND_USER} "$HOME_DIR/.m2"

cd "$HOME_DIR"/islandora/camel/component

sudo -u ${FRONTEND_USER} mvn -q install
"$KARAF_CLIENT" -b < "$KARAF_CONFIGS/component.script"