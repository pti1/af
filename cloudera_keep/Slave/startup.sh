#!/usr/bin/env bash

dnsmasq

for x in `cd /etc/init.d ; ls hadoop-hdfs-*` ; do service $x start ; done
for x in `cd /etc/init.d ; ls hadoop-yarn-*` ; do service $x start ; done


#while ! nc -z localhost 8020; do sleep 0.1; done; echo 'The server is up!'
 
ipaddress=`ifconfig eth0 | perl -n -e 'if (m/inet addr:([\d\.]+)/g) { print $1 }'`
echo "resourcemgr ui: http://$ipaddress:50070"
echo "node manager ui:http://$ipaddress:8042"
echo "yarn resource manager ui:http://$ipaddress:8088"

#sleep 15
#su -c "hadoop fs -chmod -R 777 /" hdfs

#while true; do sleep 2; done

#tail -f /var/log/hadoop-hdfs/*

/usr/sbin/sshd -D


