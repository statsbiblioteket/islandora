#!/usr/bin/env bash

set -e
export DEBIAN_FRONTEND=noninteractive
HOME_DIR=$1

/vagrant/scripts/phase1/010bootstrap.sh $HOME_DIR
/vagrant/scripts/phase1/011java.sh $HOME_DIR
/vagrant/scripts/phase1/012tomcat.sh $HOME_DIR
/vagrant/scripts/phase1/013zsh.sh $HOME_DIR
/vagrant/scripts/phase1/015IngestDir.sh $HOME_DIR
/vagrant/scripts/phase1/020solr.sh $HOME_DIR
/vagrant/scripts/phase1/040fcrepo.sh $HOME_DIR
/vagrant/scripts/phase1/050blazegraph.sh $HOME_DIR
/vagrant/scripts/phase1/060fcrepo-camel-toolbox.sh $HOME_DIR
