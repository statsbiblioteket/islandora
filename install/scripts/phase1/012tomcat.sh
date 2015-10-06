#!/usr/bin/env bash

echo "running 012tomcat.sh"

HOME_DIR=$1

. "$HOME_DIR"/islandora/install/configs/variables


cd "$HOME_DIR"

export JAVA_HOME=${JAVA8_HOME}

# Tomcat
apt-get -qq -y install ${TOMCAT_VERSION} ${TOMCAT_VERSION}-admin | grep 'Setting up' | cat
usermod -a -G ${TOMCAT_VERSION} ${FRONTEND_USER}
sed -i '$i<user username="islandora" password="islandora" roles="manager-gui"/>' ${TOMCAT_CONF}/tomcat-users.xml

# Set JAVA_HOME -- Java8 set-default does not seem to do this.
sed -i "s|#JAVA_HOME=/usr/lib/jvm/openjdk-6-jdk|JAVA_HOME=$JAVA_HOME|g" $TOMCAT_ENV
