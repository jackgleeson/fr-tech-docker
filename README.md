## Docker stack using application-specific images
Proof of concept fr-tech stack using docker-compose to demonstrate how you can run multiple dockerized applications from isolated app-specific Docker 
images with bind mounts to mount application source code to running containers allowing realtime development. 

## Install
1. run `git clone --recursive https://github.com/jackgleeson/fr-tech-docker`
2. run `cd fr-tech-docker`
3. run `docker-compose up -d` and grab a coffee
3. run `./setup.sh` and grab another coffee or snack...

## What does it install?
1. Payments-wiki running on Apache/PHP 7.4. See here: https://localhost:8001
2. Civicrm running on Apache/PHP 7.3. See here: https://localhost:8002
3. MariaDB 
4. Redis 5.0

## Project Struture
![project-structure](screenshots/project-structure.png)

## Clean up
1. run `docker-compose down -v`
2. run `rm -rf fr-tech-docker`