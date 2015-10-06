#!/bin/bash
echo "RUNNING POST-INSTALL COMMANDS"

HOME_DIR=$1
if [ -f "$HOME_DIR/islandora/install/configs/variables" ]; then
  . "$HOME_DIR"/islandora/install/configs/variables
fi

# Chown and chmod tomcat directory
chown -R ${TOMCAT_USER} $TOMCAT_HOME
chown -R ${TOMCAT_USER} $TOMCAT_LOGS
chmod -R g+w $TOMCAT_HOME

# Chown and chmod apache directory
chown -R www-data:www-data /var/www/html
chmod -R g+w /var/www/html

# Chown the home directory for good measure
chown -R ${FRONTEND_USER}:${FRONTEND_USER} "$HOME_DIR"

# Cycle tomcat
cd $TOMCAT_HOME
eval $TOMCAT_CONTROLLER restart

# Cycle karaf and watch the maven bundles
service karaf-service restart
sleep 60
"$KARAF_CLIENT" -b < "$KARAF_CONFIGS/watch.script"

# Fix ApacheSolr config
drush -q -r "$DRUPAL_HOME" sqlq "update apachesolr_environment set url='http://localhost:8080/solr' where url='http://localhost:8983/solr'"
drush -q -r "$DRUPAL_HOME" cc all

# Add DC as some default fields for folks.
drush -q -r "$DRUPAL_HOME" scr "$HOME_DIR"/islandora/install/configs/add_default_fields.php

echo "Phase 2 of install is now complete"