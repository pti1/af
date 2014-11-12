#!/usr/bin/env bash

ipaddress=`ifconfig eth0 | perl -n -e 'if (m/inet addr:([\d\.]+)/g) { print $1 }'`
echo "ip = $ipaddress"


/etc/rc.local $@ 


sleep 100000



