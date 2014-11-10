#!/usr/bin/env bash

ipaddress=`ifconfig eth0 | perl -n -e 'if (m/inet addr:([\d\.]+)/g) { print $1 }'`
echo "resourcemgr ui: http://$ipaddress:50070"
echo "node manager ui:http://$ipaddress:8042"
echo "yarn resource manager ui:http://$ipaddress:8088"

cd /opt/docker_common_scripts/
for f in *.sh;
do 
  chmod 777 ./$f
  nohup ./$f &
done


chef-client -d -i 20 -s 1 -c /etc/chef/client.rb -E "dev" -r "role[master-cloudera]" -L /var/log/chef-client.log 

echo "resourcemgr ui: http://$ipaddress:50070"
echo "node manager ui:http://$ipaddress:8042"
echo "yarn resource manager ui:http://$ipaddress:8088"



/usr/sbin/sshd -D




