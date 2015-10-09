#!/usr/bin/env bash
# Java
## There is no Java8 OpenJDK right now in the Ubuntu repos
## http://askubuntu.com/questions/464755/how-to-install-openjdk-8-on-14-04-lts
## We'll use Oracle Java8 for now.

echo "Preparing to Install Java 8 from Oracle"

HOME_DIR=$1
source "$HOME_DIR"/islandora/install/configs/variables
cd "$HOME_DIR"


set -e
if [ -f ~/java ]; then
    exit
fi

# Java (Oracle)
echo "adding repositories for java packages"
apt-get -qq -y install  software-properties-common python-software-properties | grep 'Setting up' | cat
add-apt-repository -y ppa:webupd8team/java
apt-get -qq update
debconf-set-selections <<< "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true"
debconf-set-selections <<< "oracle-java8-installer shared/accepted-oracle-license-v1-1 seen true"

echo "Installing Java 8"
apt-get -qq -y install oracle-java8-installer 2> /dev/null | grep 'Setting up' | cat
update-java-alternatives -s java-8-oracle
apt-get -qq -y install oracle-java8-set-default | grep 'Setting up' | cat
export JAVA_HOME=${JAVA8_HOME}

touch ~/java