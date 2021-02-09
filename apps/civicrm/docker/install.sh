#!/bin/bash

set -exuo pipefail

mysql -h database -u root --password=dockerpass -B -N -e 'CREATE DATABASE civicrm'
mysql -h database -u root --password=dockerpass -B -N -e 'CREATE DATABASE drupal'
mysql -h database -u root --password=dockerpass -B -N -e 'CREATE DATABASE fredge'

sudo -u docker php /var/www/html/sites/default/civicrm-install.php

sudo -u docker composer install

sudo -u docker /usr/local/bin/drush site-install standard \
  --db-url='mysql://root:dockerpass@database:3306/drupal' \
  --site-name='localhost' \
  --account-name='admin' --account-pass='dockerpass' \
  install_configure_form.update_status_module='array(FALSE,FALSE)' \
  && mv /var/www/html/sites/default/settings.php /var/www/html/sites/default/orig_settings.php \
  && mv /var/www/html/sites/default/_settings.php /var/www/html/sites/default/settings.php

sudo -u docker /usr/local/bin/drush pm-enable -v `cat /var/www/html/sites/default/enabled_modules`