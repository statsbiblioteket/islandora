#!/bin/bash

echo "running 040fcrepo.sh"

HOME_DIR=$1

. "$HOME_DIR"/islandora/install/configs/variables


if [ ! -f "$DOWNLOAD_DIR/fcrepo.war" ]; then
  echo "Downloading Fedora 4"
  wget -q -O "$DOWNLOAD_DIR/fcrepo.war" "https://github.com/fcrepo4/fcrepo4/releases/download/fcrepo-$FEDORA_VERSION/fcrepo-webapp-$FEDORA_VERSION.war"
fi

echo "Installing Fedora 4"
cd "$HOME_DIR"

if [ ! -d "$FEDORA_DATA" ]; then
  mkdir -p "$FEDORA_DATA"
fi

chown ${TOMCAT_USER} ${FEDORA_DATA}
chmod g-w ${FEDORA_DATA}

cp -v "$DOWNLOAD_DIR/fcrepo.war" ${WEBAPPS_DIR}
chown ${TOMCAT_USER} ${WEBAPPS_DIR}/fcrepo.war
sed -i 's#JAVA_OPTS="-Djava.awt.headless=true -Xmx128m -XX:+UseConcMarkSweepGC"#JAVA_OPTS="-Djava.awt.headless=true -Dfile.encoding=UTF-8 -server -Xms512m -Xmx1024m -XX:NewSize=256m -XX:MaxNewSize=256m -XX:PermSize=256m -XX:MaxPermSize=256m"#g' $TOMCAT_ENV

echo "Restaring Tomcat with Fedora 4"
eval $TOMCAT_CONTROLLER restart

