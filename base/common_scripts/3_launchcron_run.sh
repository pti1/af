#!/bin/bash

cd /opt/docker_common_scripts/
echo "" > /opt/crontab.pti
for aCron in *cron*.sh
do
  if [ "$aCron" != "3_launchcron_run.sh" ]
  then
     sched=`cat $aCron | grep cron_schedule | sed "s/.*cron_schedule //g"`

     echo "$sched /opt/docker_common_scripts/$aCron > /var/log/$aCron.log" >> /opt/crontab.pti
  fi
done
crontab /opt/crontab.pti
kill `pidof cron`
cron

