#!/bin/bash

set -xuo pipefail

# uninstall civicrm
mysql -h database -u root --password=dockerpass -e 'DROP DATABASE civicrm'
mysql -h database -u root --password=dockerpass -e 'DROP DATABASE drupal'
mysql -h database -u root --password=dockerpass -e 'DROP DATABASE fredge'

rm /var/www/html/drupal/sites/default/orig_settings.php
rm /var/www/html/drupal/sites/default/settings.php
rm /var/www/html/drupal/sites/default/civicrm.settings.php
rm /var/www/html/drupal/sites/default/civicrm-install.php
rm /var/www/html/drupal/sites/default/DonationInterface.settings.php
rm /var/www/html/drupal/sites/default/wmf_settings.json
rm /var/www/html/drupal/sites/default/wmf_settings_developer.json