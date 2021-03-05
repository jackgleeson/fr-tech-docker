#!/bin/bash

set -uo pipefail

# uninstall and remove civiproxy container
docker-compose exec civiproxy /bin/bash /docker/uninstall.sh
docker-compose rm -sf civiproxy

# create and start new civiproxy container
docker-compose up -d civiproxy

# install civicrm
docker-compose exec civiproxy /bin/bash /docker/install.sh