#!/usr/bin/env bash

ipaddress=`ifconfig eth0 | perl -n -e 'if (m/inet addr:([\d\.]+)/g) { print $1 }'`
echo "container ip:$ipaddress"

cd /opt/docker_common_scripts/
for f in *.sh;
do
  chmod 777 ./$f
  nohup ./$f &
done

for x in `cd /etc/init.d ; ls hadoop-hdfs-*` ; do service $x start ; done
for x in `cd /etc/init.d ; ls hadoop-yarn-*` ; do service $x start ; done

echo "container ip:$ipaddress"

chef-client -d -i 20 -s 1 -c /etc/chef/client.rb -E "dev" -r "role[slave-cloudera]" -L /var/log/chef-client.log

/usr/sbin/sshd -D


