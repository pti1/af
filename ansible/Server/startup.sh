#!/usr/bin/env bash


 
ipaddress=`ifconfig eth0 | perl -n -e 'if (m/inet addr:([\d\.]+)/g) { print $1 }'`
echo "ansible server: $ipaddress"

/etc/rc.local

echo "SLEEPING...."
sleep 100000



