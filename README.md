## Docker stack using application-specific images
Skeleton app using docker-compose to demonstrate how you can run multiple dockerized applications from isolated app-specific Docker 
images using bind mounts to mount application source code to running containers allowing realtime development. 

## Install
1. run `git clone --recursive https://github.com/jackgleeson/docker-example`
2. run `cd docker-example`
3. run `docker-compose up -d`

## What does it install?
1. Skeleton PHP 7.3 app named _payments_ with source code mounted. See here: http://localhost:8001
2. Skeleton PHP 7.4 app named _civicrm_ with source code mounted. See here: http://localhost:8002
3. Skeleton PHP 8 app named _php-8-is-here_!!! with source code mounted. See here: http://localhost:8003 
4. Skeleton Python 3 app named _fundraising-tools_ with source code mounted. See here: http://localhost:8004
5. Dockerized version of _process-control_ with source code mounted. 
To play with a running instance run `docker-compose run --user pc-user process-control bash` which will 
drop you in the container src directory. Make any changes you want (maybe to the example job?) and then run
`pip3 install -e .` to rerun distutils setup.py install and then call your jobs using 
`run-job -j example_job`.

## Clean up
1. run `docker-compose down`
2. run `rm -rf docker-example`