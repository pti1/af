#!/bin/bash

cd /opt/docker_common_scripts/
for aRun in *run*.sh
do
  if [ "$aRun" != "2_launchrun.sh" ]
  then
     chmod 777 $aRun
     nohup bash ./$aRun $@ </dev/null 1> /var/log/$aRun.log 2>&1
     #sleep 5
  fi
done

