#!/bin/bash

set -exuo pipefail

sudo -u runuser composer install --no-dev

mysql -h database -u root --password=dockerpass -B -N -e 'CREATE DATABASE civicrm'
mysql -h database -u root --password=dockerpass -B -N -e 'CREATE DATABASE drupal'
mysql -h database -u root --password=dockerpass -B -N -e 'CREATE DATABASE fredge'

sudo -u www-data php /var/www/html/sites/default/civicrm-install.php

/usr/local/bin/drush site-install standard \
  --db-url='mysql://root:dockerpass@database:3306/drupal' \
  --site-name='localhost' \
  --account-name='admin' --account-pass='dockerpass' \
  install_configure_form.update_status_module='array(FALSE,FALSE)' \
  && mv /var/www/html/sites/default/settings.php /var/www/html/sites/default/orig_settings.php \
  && mv /var/www/html/sites/default/_settings.php /var/www/html/sites/default/settings.php

/usr/local/bin/drush pm-enable `cat /var/www/html/sites/default/enabled_modules`