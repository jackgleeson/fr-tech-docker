#!/bin/bash

set -exuo pipefail

# TODO: admin user not there on fresh install.
#mysql -h database -u root --password=dockerpass 'civicrm' -qs < /docker/sql/add-civiproxy-api-key.sql

# setup config
if [ ! -f "/var/www/html/config.php" ]; then
  mv /var/www/html/proxy.php /var/www/html/proxy.php.bk
  cp /docker/config/config.php /docker/config/proxy.php /var/www/html/
  chown docker:docker /var/www/html/config.php /var/www/html/proxy.php /var/www/html/proxy.php.bk
fi
