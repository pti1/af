#!/usr/bin/env bash


 
ipaddress=`ifconfig eth0 | perl -n -e 'if (m/inet addr:([\d\.]+)/g) { print $1 }'`
echo "chef serveur ui: https://$ipaddress"

/usr/sbin/sshd -D




