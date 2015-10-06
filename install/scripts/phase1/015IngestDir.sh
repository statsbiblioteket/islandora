#!/usr/bin/env bash

echo "running 015IngestDir.sh"

HOME_DIR=$1

. "$HOME_DIR"/islandora/install/configs/variables

cd "$HOME_DIR"


# Make the ingest directory
if [ ! -d "/mnt/ingest" ]; then
  mkdir -p /mnt/ingest
fi
chown -R ${TOMCAT_USER} /mnt/ingest

