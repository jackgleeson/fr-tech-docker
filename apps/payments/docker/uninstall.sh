#!/bin/bash

set -xuo pipefail

# uninstall payments-wiki
mysql -h database -u root --password=dockerpass -e 'DROP DATABASE '"$MW_DB_NAME"

if [ -f "/var/www/html/LocalSettings.php" ]; then
    rm /var/www/html/LocalSettings.php
fi