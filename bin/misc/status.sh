#!/bin/bash
echo "+ Running containers +"
docker-compose ps

echo
echo "+ Git Status +"
git submodule foreach --recursive 'git status -sb'