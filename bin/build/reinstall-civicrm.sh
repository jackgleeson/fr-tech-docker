#!/bin/bash

set -uo pipefail

# uninstall and remove civicrm container
docker-compose exec civicrm /bin/bash /docker/uninstall.sh
docker-compose rm -sf civicrm

# create and start new civicrm container
docker-compose up -d civicrm

# install civicrm
docker-compose exec civicrm /bin/bash /docker/install.sh