#!/bin/bash

set -exuo pipefail

mysql -h database -u root --password=dockerpass -e 'CREATE DATABASE smashpig'
cat /var/www/html/Schema/mysql/*.sql | mysql -h database -u root --password=dockerpass 'smashpig' -qs

sudo -u docker composer install

# setup .htaccess
HTACCESS=${PWD}"/PublicHttp/.htaccess"
if [ ! -f "$HTACCESS" ]; then
    cp /var/www/html/PublicHttp/.htaccess.sample /var/www/html/PublicHttp/.htaccess
    chown docker:docker /var/www/html/PublicHttp/.htaccess
fi

