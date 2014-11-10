#!/usr/bin/env bash

cd /opt/docker_common_scripts/
for f in *.sh;
do 
  chmod 777 ./$f
  nohup ./$f &
done


chef-client -d -i 120 -s 5 -c /etc/chef/client.rb
/usr/sbin/sshd -D




