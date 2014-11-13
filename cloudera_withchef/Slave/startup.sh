#!/usr/bin/env bash

myenv=""

if [[ $@ =~ .*--env.* ]]
then
else
  myenv="--env=dev"
fi



ipaddress=`ifconfig eth0 | perl -n -e 'if (m/inet addr:([\d\.]+)/g) { print $1 }'`
echo "container ip:$ipaddress"

/etc/rc.local $@ $myenv --runlist="role[slave-cloudera]"

echo "container ip:$ipaddress"


echo "SLEEPING...."
sleep 1000000

