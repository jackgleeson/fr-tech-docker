#!/bin/bash
docker-compose exec -u docker smashpig php /var/www/html/Maintenance/QueueJobRunner.php --config-node adyen --queue jobs-adyen