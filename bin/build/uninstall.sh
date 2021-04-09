#!/bin/bash

set -uo pipefail
echo ">>> Begin Uninstall!"

docker-compose exec payments /bin/bash /docker/uninstall.sh
docker-compose exec smashpig /bin/bash /docker/uninstall.sh
docker-compose exec civicrm /bin/bash /docker/uninstall.sh
docker-compose exec civiproxy /bin/bash /docker/uninstall.sh

# stop and remove running containers and also remove volumes
docker-compose down -v  --remove-orphans

echo ">>> Uninstall complete!"