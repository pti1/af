#!/usr/bin/env bash

ipaddress=`ifconfig eth0 | perl -n -e 'if (m/inet addr:([\d\.]+)/g) { print $1 }'`
echo "ganglia ui: http://$ipaddress/ganglia"

/etc/rc.local $@ --env=admin --runlist="recipe[ganglia::ganglia-server]"

service gmetad restart 
service apache2 restart


echo "ganglia ui: http://$ipaddress/ganglia"

echo "SLEEPING...."
sleep 100000 

