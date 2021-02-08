#!/bin/bash

set -euo pipefail

# Install Payments-wiki
docker-compose exec -u runuser payments /bin/bash /docker/install.sh

# Install CiviCRM
docker-compose exec -u runuser civicrm /bin/bash /docker/install.sh