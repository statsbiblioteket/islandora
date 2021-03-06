#!/bin/bash

echo "running 050blazegraph.sh"

HOME_DIR=$1

. "$HOME_DIR"/islandora/install/configs/variables


set -e
if [ -f ~/blazegraph ]; then
    exit
fi

if [ ! -f "$DOWNLOAD_DIR/bigdata.war" ]; then
  echo "Downloading Blazegraph"
  wget -q -O "$DOWNLOAD_DIR/bigdata.war" "http://sourceforge.net/projects/bigdata/files/bigdata/$BLAZEGRAPH_VERSION/bigdata.war/download"
fi

cd ${WEBAPPS_DIR}
cp -v "$DOWNLOAD_DIR/bigdata.war" ${WEBAPPS_DIR}
chown ${TOMCAT_USER} ${WEBAPPS_DIR}/bigdata.war

if [ $(grep -c 'com.bigdata.rdf.sail.webapp' ${TOMCAT_ENV}) -eq 0 ]; then
	echo "JAVA_OPTS=\"\$JAVA_OPTS -Dcom.bigdata.rdf.sail.webapp.ConfigParams.propertyFile=$WEBAPPS_DIR/bigdata/WEB-INF/RWStore.properties\"" >> ${TOMCAT_ENV}
fi

eval $TOMCAT_CONTROLLER restart

touch ~/blazegraph