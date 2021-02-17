#!/bin/bash

set -xuo pipefail

# uninstall civicrm
mysql -h database -u root --password=dockerpass -e 'DROP DATABASE civicrm'
mysql -h database -u root --password=dockerpass -e 'DROP DATABASE drupal'
mysql -h database -u root --password=dockerpass -e 'DROP DATABASE fredge'

rm /var/www/html/sites/default/orig_settings.php
rm /var/www/html/sites/default/settings.php
rm /var/www/html/sites/default/civicrm.settings.php
rm /var/www/html/sites/default/civicrm-install.php
rm /var/www/html/sites/default/DonationInterface.settings.php