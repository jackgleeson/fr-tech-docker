#!/bin/bash
cd ./config
ln -sfn ../apps/payments/docker/config payments
ln -sfn ../apps/civicrm/docker/config civicrm
ln -sfn ../apps/smashpig/docker/config smashpig
ln -sfn ../apps/civiproxy/docker/config civiproxy
