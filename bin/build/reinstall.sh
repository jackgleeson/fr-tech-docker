#!/bin/bash

set -uo pipefail

docker-compose exec payments /bin/bash /docker/uninstall.sh
docker-compose exec smashpig /bin/bash /docker/uninstall.sh
docker-compose exec civicrm /bin/bash /docker/uninstall.sh

# stop and remove running containers and also remove volumes
docker-compose down -v --remove-orphans

# call setup.sh
./setup.sh