#!/usr/bin/env bash

ruby /opt/updatehostfile.rb

for x in `cd /etc/init.d ; ls hadoop-hdfs-*` ; do service $x start ; done
for x in `cd /etc/init.d ; ls hadoop-yarn-*` ; do service $x start ; done

echo "wait for hdfs to be ready"
until hadoop fs -ls /; do
  echo hadoop not yet up...
  sleep 2
done

echo "create pascal user"
useradd -m pascal

echo "yarn hdfs config"
su -c "hadoop fs -rm -r /tmp" hdfs
su -c "hadoop fs -chmod -R 1777 /tmp"  hdfs
su -c "hadoop fs -mkdir /tmp/hadoop-yarn/staging" hdfs
su -c "hadoop fs -chmod -R 777 /tmp/hadoop-yarn/staging" hdfs
su -c "hadoop fs -mkdir -p /tmp/hadoop-yarn/staging/history/done_intermediate" hdfs
su -c "hadoop fs -chown -R mapred:mapred /tmp/hadoop-yarn/staging"  hdfs
su -c "hadoop fs -mkdir -p /var/log/hadoop-yarn"  hdfs
su -c "hadoop fs -chown yarn:mapred /var/log/hadoop-yarn"  hdfs

echo "create users directories"
su -c "hadoop fs -mkdir -p /user/root" hdfs
su -c "hadoop fs -chown root:root /user/root" hdfs
su -c "hadoop fs -mkdir -p /user/pascal" hdfs
su -c "hadoop fs -chown pascal:pascal /user/pascal" hdfs


 
ipaddress=`ifconfig eth0 | perl -n -e 'if (m/inet addr:([\d\.]+)/g) { print $1 }'`
echo "resourcemgr ui: http://$ipaddress:50070"
echo "node manager ui:http://$ipaddress:8042"
echo "yarn resource manager ui:http://$ipaddress:8088"



/usr/sbin/sshd -D




