#!/bin/sh

sudo -u www-data -- /var/www/html/vendor/bin/drush -y --root=/var/www/html/drupal "$@"