#!/usr/bin/env bash

ruby /opt/updatehostfile.rb



for x in `cd /etc/init.d ; ls hadoop-hdfs-*` ; do service $x start ; done
for x in `cd /etc/init.d ; ls hadoop-yarn-*` ; do service $x start ; done

ipaddress=`ifconfig eth0 | perl -n -e 'if (m/inet addr:([\d\.]+)/g) { print $1 }'`
echo "resourcemgr ui: http://$ipaddress:50070"
echo "node manager ui:http://$ipaddress:8042"
echo "yarn resource manager ui:http://$ipaddress:8088"


/usr/sbin/sshd -D


