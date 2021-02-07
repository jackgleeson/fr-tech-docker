#!/bin/bash
docker-compose exec payments php tests/phpunit/phpunit.php --group DonationInterface