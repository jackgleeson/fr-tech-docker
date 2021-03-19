## Fundraising Tech Docker stack
fr-tech docker stack using vanilla Dockerfiles. 

## Install
1. run `git clone --recursive https://github.com/jackgleeson/fr-tech-docker` and `cd fr-tech-docker`
3. run `./setup.sh` and grab a coffee because it might take a while first time around. 

## What does it install?
1. Payments-wiki running on Apache/PHP 7.4. See here:https://localhost:8001/index.php/Main_Page
2. CiviCRM running on Apache/PHP 7.3. See here: https://localhost:8002/civicrm
3. SmashPig running on Apache/PHP 7.4. See here: https://localhost:8003/adyen
4. CiviProxy running on Apache/PHP 7.4. See here: https://localhost:8004
5. MariaDB 
6. Redis 5.0

## Stack Struture
![project-structure](screenshots/project-structure.png)

## Docker commands
#### Daily commands
- run `docker-compose up -d` up the stack
- run `docker-compose down` down the stack
#### Throw it all away and start again (takes about 5 minutes to reinstall everything)
- run `./bin/build/reinstall.sh`
##### Note: You can reinstall specific app by passing the name of the app e.g. `./bin/build/reinstall-civicrm.sh`
### Rebuild the stack images (do this when you edit the Dockerfiles)
- run `docker-compose build` rebuild the underlying Docker images. 
##### Note: You can rebuild specific images by passing the name of the service as an argument e.g. `docker-compose build civicrm`
### Delete everything 
- run `docker-compose down -v -rmi all` to stop & remove containers and clear out the database and queues and delete the images
- run `rm -rf fr-tech-docker`

## Other
- checkout `/bin` for a bunch of useful shortcuts