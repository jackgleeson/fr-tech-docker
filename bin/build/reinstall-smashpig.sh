#!/bin/bash

set -uo pipefail

# uninstall and remove smashpig container
docker-compose exec smashpig /bin/bash /docker/uninstall.sh
docker-compose rm -sf smashpig

# create and start new civicrm container
docker-compose up -d smashpig

# install civicrm
docker-compose exec smashpig /bin/bash /docker/install.sh