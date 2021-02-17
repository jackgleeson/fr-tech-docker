#!/bin/bash
read -p  "You really want to clear out all log data in ./logs? (y/n) " answer
if [[ "$answer" =~ [Yy] ]] ;then
    for f in ./logs/*.log; do echo $f" cleared" && >$f; done;
fi