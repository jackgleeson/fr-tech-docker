#!/bin/bash

set -xuo pipefail

# uninstall smashpig
mysql -h database -u root --password=dockerpass -e 'DROP DATABASE smashpig'

# reset .htaccess
HTACCESS=${PWD}"/PublicHttp/.htaccess"
if [ -f "$HTACCESS" ]; then
    rm /var/www/html/PublicHttp/.htaccess
fi