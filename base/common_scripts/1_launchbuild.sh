#!/bin/bash

cd /opt/docker_common_scripts/
for aBuild in *build*.sh
do
  if [ "$aBuild" != "1_launchbuild.sh" ]
  then
     chmod 777 $aBuild
     . ./$aBuild
  fi
done

