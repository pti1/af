#!/usr/bin/env bash

ipaddress=`ifconfig eth0 | perl -n -e 'if (m/inet addr:([\d\.]+)/g) { print $1 }'`
echo "resourcemgr ui: http://$ipaddress:50070"
echo "node manager ui:http://$ipaddress:8042"
echo "yarn resource manager ui:http://$ipaddress:8088"

cd /opt/docker_common_scripts/
for f in *.sh; do . ./$f; done


/usr/sbin/sshd -D&

chef-client -i 20 -s 1 -c /etc/chef/client.rb -E "dev" -r "role[master-cloudera]" 


/usr/sbin/sshd -D




