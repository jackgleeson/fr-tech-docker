#!/bin/bash

set -exuo pipefail

# Install Payments-wiki
docker-compose exec -u runuser payments /bin/bash /docker/install.sh

# Install CiviCRM