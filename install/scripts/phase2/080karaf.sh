#!/bin/bash
echo "Installing Karaf"

HOME_DIR=$1

if [ -f "$HOME_DIR/islandora/install/configs/variables" ]; then
  . "$HOME_DIR"/islandora/install/configs/variables
fi

if [ ! -f "$DOWNLOAD_DIR/apache-karaf-$KARAF_VERSION.tar.gz" ]; then
  echo "Downloading Karaf"
  wget -q -O "$DOWNLOAD_DIR/apache-karaf-$KARAF_VERSION.tar.gz" "http://mirror.csclub.uwaterloo.ca/apache/karaf/$KARAF_VERSION/apache-karaf-$KARAF_VERSION.tar.gz"
fi

cd "$HOME_DIR"

echo "Download and install Karaf"
cp -v "$DOWNLOAD_DIR/apache-karaf-$KARAF_VERSION.tar.gz" "$HOME_DIR"
tar zxf apache-karaf-"$KARAF_VERSION".tar.gz
rm apache-karaf-"$KARAF_VERSION".tar.gz
mv apache-karaf-"$KARAF_VERSION" /opt
ln -s /opt/apache-karaf-"$KARAF_VERSION" /opt/karaf

echo "Run a setup script to add some feature repos and prepare it for running as a service"
/opt/karaf/bin/start
sleep 60
"$KARAF_CLIENT" < "$KARAF_CONFIGS/setup.script"
/opt/karaf/bin/stop

echo "Add Karaf as a Linux service"
ln -s /opt/karaf/bin/karaf-service /etc/init.d/
update-rc.d karaf-service defaults

# Maven
echo "Installing Maven for Karaf"
apt-get -y -qq install maven | grep 'Setting up' | cat
# Add the vagrant user's maven repository
sed -i "s|#org.ops4j.pax.url.mvn.localRepository=|org.ops4j.pax.url.mvn.localRepository=$HOME_DIR/.m2/repository|" /opt/karaf/etc/org.ops4j.pax.url.mvn.cfg

echo "Start Karaf"
service karaf-service start
sleep 60
