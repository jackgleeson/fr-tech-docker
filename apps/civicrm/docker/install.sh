#!/bin/bash

set -exuo pipefail
mysql -h database -u root --password=dockerpass < /docker/sql/civicrm.sql
mysql -h database -u root --password=dockerpass -e 'CREATE DATABASE drupal'
mysql -h database -u root --password=dockerpass -e 'CREATE DATABASE fredge'
cat /docker/sql/fredge/*.sql | mysql -h database -u root --password=dockerpass 'fredge' -qs

sudo -u docker composer install

#install drupal
sudo -u docker cp /docker/config/drupal/* /var/www/html/drupal/sites/default/
sudo -u docker /usr/local/bin/drush site-install standard \
  --db-url='mysql://root:dockerpass@database:3306/drupal' \
  --site-name='localhost' \
  --account-name='admin' --account-pass='dockerpass' \
  install_configure_form.update_status_module='array(FALSE,FALSE)'
chmod 755 /var/www/html/drupal/sites/default

#install civicrm
sudo -u docker php /var/www/html/drupal/sites/default/civicrm-install.php

#additional setup
sudo -u docker /usr/local/bin/drush pm-enable -v `cat /var/www/html/drupal/sites/default/enabled_modules`
sudo -u docker /usr/local/bin/drush updatedb
sudo -u docker /usr/local/bin/drush en tivy
sudo -u docker /usr/local/bin/drush vset theme_default tivy
sudo -u docker /usr/local/bin/drush -y dis overlay
sudo -u docker /usr/local/bin/drush scr /docker/civicrm-buildkit/app/config/wmff/install-theme.php
sudo -u docker /usr/local/bin/drush php-eval 'module_load_include("inc","block","block.admin"); block_admin_display();'
sudo -u docker /usr/local/bin/drush --in=json cvapi Setting.create < "/docker/config/drupal/wmf_settings_developer.json"
sudo -u docker /usr/local/bin/drush --in=json cvapi Setting.create < "/docker/config/drupal/wmf_settings.json"
mv /var/www/html/drupal/sites/default/settings.php /var/www/html/drupal/sites/default/orig_settings.php
mv /var/www/html/drupal/sites/default/_settings.php /var/www/html/drupal/sites/default/settings.php
chown docker:docker /var/www/html/drupal/sites/default/settings.php /var/www/html/drupal/sites/default/orig_settings.php