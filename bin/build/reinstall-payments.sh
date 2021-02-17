#!/bin/bash

set -uo pipefail

# uninstall and remove payments-wiki container
docker-compose exec payments /bin/bash /docker/uninstall.sh
docker-compose rm -sf payments

# create and start new payments container
docker-compose up -d payments

# install payments-wiki
docker-compose exec payments /bin/bash /docker/install.sh