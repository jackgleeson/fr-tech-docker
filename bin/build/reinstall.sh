#!/bin/bash

set -uo pipefail

# call uninstall.sh
./bin/build/uninstall.sh

# call setup.sh
./setup.sh