#!/bin/bash

echo "running 060fcrepo-camel-toolbox.sh"

HOME_DIR=$1

. "$HOME_DIR"/islandora/install/configs/variables

if [ ! -f "$DOWNLOAD_DIR/fcrepo-camel-toolbox.war" ]; then
  echo "Downloading fcrepo-camel-toolbox"
  wget -O "$DOWNLOAD_DIR/fcrepo-camel-toolbox.war" "https://github.com/fcrepo4-labs/fcrepo-camel-toolbox/releases/download/fcrepo-camel-toolbox-$CAMEL_VERSION/fcrepo-camel-webapp-at-is-it-$CAMEL_VERSION.war"
fi

cd ${WEBAPPS_DIR}
cp -v "$DOWNLOAD_DIR/fcrepo-camel-toolbox.war" "$WEBAPPS_DIR"
chown ${TOMCAT_USER} ${WEBAPPS_DIR}/fcrepo-camel-toolbox.war

if [ $(grep -c '\-Dtriplestore.baseUrl=' $TOMCAT_ENV) -eq 0 ]; then
  echo "JAVA_OPTS=\"\$JAVA_OPTS -Dtriplestore.baseUrl=localhost:8080/bigdata/sparql\"" >> $TOMCAT_ENV
fi

eval $TOMCAT_CONTROLLER restart

echo "Phase 1 of install is now complete"