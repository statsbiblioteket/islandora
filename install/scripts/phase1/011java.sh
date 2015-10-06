#!/usr/bin/env bash
# Java
## There is no Java8 OpenJDK right now in the Ubuntu repos
## http://askubuntu.com/questions/464755/how-to-install-openjdk-8-on-14-04-lts
## We'll use Oracle Java8 for now.

HOME_DIR=$1

if [ -f "$HOME_DIR/islandora/install/configs/variables" ]; then
  . "$HOME_DIR"/islandora/install/configs/variables
fi

cd "$HOME_DIR"


# Java (Oracle)
sudo apt-get install -y software-properties-common
sudo apt-get install -y python-software-properties
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get update
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
sudo apt-get install -y oracle-java8-installer
sudo update-java-alternatives -s java-8-oracle
sudo apt-get install -y oracle-java8-set-default
export JAVA_HOME=${JAVA8_HOME}
