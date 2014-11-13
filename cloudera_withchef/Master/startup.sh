#!/usr/bin/env bash

myenv=""

if [[ $@ =~ .*--env.* ]]
then
  echo "using env provided in command line"
else
  myenv="--env=dev"   
fi 



ipaddress=`ifconfig eth0 | perl -n -e 'if (m/inet addr:([\d\.]+)/g) { print $1 }'`
echo "resourcemgr ui: http://$ipaddress:50070"
echo "node manager ui:http://$ipaddress:8042"
echo "yarn resource manager ui:http://$ipaddress:8088"


/etc/rc.local $@ $myenv --runlist="role[master-cloudera]"


echo "resourcemgr ui: http://$ipaddress:50070"
echo "node manager ui:http://$ipaddress:8042"
echo "yarn resource manager ui:http://$ipaddress:8088"

echo "SLEEPING...."
sleep 100000





