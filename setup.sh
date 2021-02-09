#!/bin/bash

set -euo pipefail

# Setup uid/gid
echo -e "DOCKER_UID=$(id -u)\nDOCKER_GID=$(id -g)" > .env

# Build the stack
docker-compose up -d

# Wait a bit the for the database install to finish
while ! docker-compose exec database /bin/mysql -u root --password=dockerpass -e "SELECT 1" >/dev/null; do
  sleep 1 && printf '.'
done

# Install Payments-wiki
./bin/install/payments-install.sh

# Install CiviCRM
./bin/install/civicrm-install.sh
