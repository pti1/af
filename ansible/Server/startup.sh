#!/usr/bin/env bash


 
ipaddress=`ifconfig eth0 | perl -n -e 'if (m/inet addr:([\d\.]+)/g) { print $1 }'`
echo "ansible server: $ipaddress"

/etc/rc.local

#echo -e  'y\n'|ssh-keygen -q -t rsa -N "" -f ~/.ssh/id_rsa && \
#cp ~/.ssh/id_rsa.pub ~/.ssh/authorized_keys


echo "SLEEPING...."
sleep 100000



