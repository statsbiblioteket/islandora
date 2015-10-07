#!/bin/bash

HOME_DIR=$1

if [ -f "$HOME_DIR/islandora/install/configs/variables" ]; then
  . "$HOME_DIR"/islandora/install/configs/variables
fi

cd "$HOME_DIR"

# Drush and drupal deps
echo "Installing Drush"
apt-get -y -qq install php5-gd | grep 'Setting up' | cat
apt-get -y -qq install drush | grep 'Setting up' | cat
a2enmod rewrite
service apache2 reload
cd /var/www/html

# Download Drupal
echo "Installing Drupal"
drush dl -y -q drupal --drupal-project-rename=drupal

# Permissions
chown -R www-data:www-data drupal
chmod -R g+w drupal

# Do the install
cd "$DRUPAL_HOME"
drush si -y --db-url=mysql://root:islandora@localhost/drupal7 --site-name=Islandora-7.x-2.x
drush user-password admin --password=islandora

# Set document root
sed -i 's|DocumentRoot /var/www/html$|DocumentRoot /var/www/html/drupal|' /etc/apache2/sites-enabled/000-default.conf

# Set override for drupal directory
# TODO Don't do this in main apache conf
sed -i '$i<Directory /var/www/html/drupal>' /etc/apache2/apache2.conf
sed -i '$i\\tOptions Indexes FollowSymLinks' /etc/apache2/apache2.conf
sed -i '$i\\tAllowOverride All' /etc/apache2/apache2.conf
sed -i '$i\\tRequire all granted' /etc/apache2/apache2.conf
sed -i '$i</Directory>' /etc/apache2/apache2.conf

# Torch the default index.html
rm /var/www/html/index.html

# Cycle apache
service apache2 restart

echo "Installing Islandora dependencies"
# Make the modules and libraries directories
if [ ! -d "$DRUPAL_HOME/sites/all/modules" ]; then
  mkdir -p "$DRUPAL_HOME/sites/all/modules"
fi

if [ ! -d "$DRUPAL_HOME/sites/all/libraries" ]; then
  mkdir -p "$DRUPAL_HOME/sites/all/libraries"
fi

cd "$DRUPAL_HOME/sites/all/modules"
drush dl httprl
drush dl services
drush dl field_permissions
drush dl field_readonly
drush dl views
drush dl rdfx
drush dl entity
drush dl uuid
drush dl xml_field
drush dl jquery_update
git clone https://github.com/Islandora-Labs/xpath_field.git
drush dl hook_post_action

# Devel!
drush dl devel
drush -y en devel

# Undocumented dependency for rdfx on ARC2 for RDF generation.
cd "$DRUPAL_HOME/sites/all/libraries"
mkdir ARC2
cd ARC2
git clone https://github.com/semsol/arc2.git
mv arc2 arc

cd "$DRUPAL_HOME/sites/all/modules"

# Apache Solr
drush dl apachesolr
drush en -y apachesolr
echo "Copy new schema files to Solr and restart Tomcat"
cp -f apachesolr/solr-conf/solr-4.x/* "$SOLR_HOME/collection1/conf/"
eval $TOMCAT_CONTROLLER restart

echo "Installing Islandora Modules"
# Islandora modules
ln -s "$HOME_DIR"/islandora/drupal "$DRUPAL_HOME/sites/all/modules/islandora"
drush -y en islandora
drush -y en islandora_dc
drush -y en islandora_mods
drush -y en islandora_basic_image
drush -y en islandora_collection
drush -y en islandora_apachesolr
drush -y en islandora_delete_by_fedora_uri_service
drush -y en islandora_medium_size_service
drush -y en islandora_tn_service

echo "Installing Drupal Themes"
# Set default theme to bootstrap
cd "$DRUPAL_HOME/sites/all/themes"
drush -y dl bootstrap
drush -y en bootstrap
drush vset theme_default bootstrap

echo "Install Coder & Code Sniffer"
pear install PHP_CodeSniffer
if [ ! -f "$DOWNLOAD_DIR/coder-8.x-2.1.tar.gz" ]; then
  echo "Downloading coder"
  wget -q -O "$DOWNLOAD_DIR/coder-8.x-2.1.tar.gz" http://ftp.drupal.org/files/projects/coder-8.x-2.1.tar.gz
fi
cp  "$DOWNLOAD_DIR/coder-8.x-2.1.tar.gz" /tmp
cd /tmp
tar -xzf coder-8.x-2.1.tar.gz
mv  /tmp/coder /usr/share
chown -hR ${FRONTEND_USER}:${FRONTEND_USER} /usr/share/coder
ln -s /usr/share/coder/coder_sniffer/Drupal /usr/share/php/PHP/CodeSniffer/Standards
