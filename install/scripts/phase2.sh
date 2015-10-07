#!/usr/bin/env bash

set -e

export DEBIAN_FRONTEND=noninteractive

HOME_DIR=$1

echo "Starting phase 2 of install"

/vagrant/scripts/phase2/014lamp-server.sh $HOME_DIR
/vagrant/scripts/phase2/030drupal.sh $HOME_DIR
/vagrant/scripts/phase2/070islandora-commands.sh $HOME_DIR
/vagrant/scripts/phase2/080karaf.sh $HOME_DIR
/vagrant/scripts/phase2/090karaf-hawtio.sh $HOME_DIR
/vagrant/scripts/phase2/100karaf-camel.sh $HOME_DIR
/vagrant/scripts/phase2/110karaf-fcrepo-camel.sh $HOME_DIR
/vagrant/scripts/phase2/120karaf-activemq.sh $HOME_DIR
/vagrant/scripts/phase2/130karaf-config.sh $HOME_DIR
/vagrant/scripts/phase2/140karaf-islandora-component.sh $HOME_DIR
/vagrant/scripts/phase2/150sync.sh $HOME_DIR
/vagrant/scripts/phase2/160services.sh $HOME_DIR
/vagrant/scripts/phase2/170post-install.sh $HOME_DIR

echo "Phase 2 of install is now complete"