#!/bin/bash
docker-compose  exec -u docker civicrm php vendor/bin/phpunit $@