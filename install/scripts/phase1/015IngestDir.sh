#!/usr/bin/env bash

HOME_DIR=$1

if [ -f "$HOME_DIR/islandora/install/configs/variables" ]; then
  . "$HOME_DIR"/islandora/install/configs/variables
fi

cd "$HOME_DIR"


# Make the ingest directory
if [ ! -d "/mnt/ingest" ]; then
  mkdir -p /mnt/ingest
fi
chown -R ${TOMCAT_USER} /mnt/ingest

