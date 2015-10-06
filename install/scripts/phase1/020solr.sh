#!/bin/bash

echo "Installing Solr"

HOME_DIR=$1

if [ -f "$HOME_DIR/islandora/install/configs/variables" ]; then
  . $PWD/islandora/install/configs/variables
fi

if [ ! -f "$DOWNLOAD_DIR/solr-$SOLR_VERSION.tgz" ]; then
  echo "Downloading Solr"
  wget -q -O "$DOWNLOAD_DIR/solr-$SOLR_VERSION.tgz" "http://archive.apache.org/dist/lucene/solr/$SOLR_VERSION/solr-$SOLR_VERSION.tgz"
fi

# Prepare SOLR_HOME
if [ ! -d "$SOLR_HOME" ]; then
  mkdir "$SOLR_HOME"
fi

cp -v "$DOWNLOAD_DIR/solr-$SOLR_VERSION.tgz" /tmp
cd /tmp
tar -xzvf solr-"$SOLR_VERSION".tgz
cp -v "solr-$SOLR_VERSION/dist/solr-$SOLR_VERSION.war" ${WEBAPPS_DIR}/solr.war
chown ${TOMCAT_USER} ${WEBAPPS_DIR}/solr.war

if [ ! -f "$DOWNLOAD_DIR/commons-logging-1.1.2.jar" ]; then
  echo "Downloading commons-logging-1.1.2.jar"
  wget -q -O "$DOWNLOAD_DIR/commons-logging-1.1.2.jar" "http://repo1.maven.org/maven2/commons-logging/commons-logging/1.1.2/commons-logging-1.1.2.jar"
fi
cp -v "$DOWNLOAD_DIR/commons-logging-1.1.2.jar" ${TOMCAT_LIBS}
cp /tmp/solr-${SOLR_VERSION}/example/lib/ext/slf4j* ${TOMCAT_LIBS}
cp /tmp/solr-${SOLR_VERSION}/example/lib/ext/log4j* ${TOMCAT_LIBS}

chown -hR ${TOMCAT_USER} $TOMCAT_LIBS

cp -Rv /tmp/solr-"$SOLR_VERSION"/example/solr/* "$SOLR_HOME"

chown -hR ${TOMCAT_USER} "$SOLR_HOME"

touch ${TOMCAT_LOGS}/velocity.log
chown ${TOMCAT_USER} ${TOMCAT_LOGS}/velocity.log

eval $TOMCAT_CONTROLLER restart
