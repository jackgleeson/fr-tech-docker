#!/bin/bash
docker-compose  exec -u docker payments php tests/phpunit/phpunit.php --group DonationInterface,FundraisingEmailUnsubscribe $@