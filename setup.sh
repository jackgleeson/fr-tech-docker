#!/bin/bash

set -exuo pipefail

docker-compose exec payments /bin/bash /docker/install.sh
