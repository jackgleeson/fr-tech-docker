#!/bin/bash

set -xuo pipefail

mysql -h database -u root --password=dockerpass 'civicrm' -qs < /docker/sql/remove-civiproxy-api-key.sql

# remove config & proxy override
if [ -f "/var/www/html/config.php" ]; then
   rm /var/www/html/config.php
   rm /var/www/html/proxy.php
   mv /var/www/html/proxy.php.bk /var/www/html/proxy.php
   chown docker:docker /var/www/html/proxy.php
fi