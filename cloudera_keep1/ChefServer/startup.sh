#!/usr/bin/env bash

#for dns
dnsmasq

sysctl -w kernel.shmmax=17179869184 # for postgres
/opt/chef-server/embedded/bin/runsvdir-start &
 
ipaddress=`ifconfig eth0 | perl -n -e 'if (m/inet addr:([\d\.]+)/g) { print $1 }'`
echo "chef server ui: https://$ipaddress:443"




/usr/sbin/sshd -D




