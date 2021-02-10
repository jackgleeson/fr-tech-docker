#!/bin/bash

set -euo pipefail

# setup uid/gid
echo -e "DOCKER_UID=$(id -u)\nDOCKER_GID=$(id -g)" > .env

# build the images and run the containers
docker-compose up -d

# wait a bit the for the database startup to finish
while ! docker-compose exec database /bin/mysql -u root --password=dockerpass -e "SELECT 1" >/dev/null; do
  sleep 1 && printf '.'
done

# setup payments-wiki
(cd ./apps/payments/src && git checkout fundraising/REL1_35)
(cd ./apps/payments/src/extensions/DonationInterface && git checkout master)
docker-compose exec payments /bin/bash /docker/install.sh

# setup smashpig
docker-compose exec smashpig /bin/bash /docker/install.sh

# setup civicrm
(cd ./apps/civicrm/src && git checkout master && git submodule update --init)
docker-compose exec civicrm /bin/bash /docker/install.sh


