#!/usr/bin/env bash


ipaddress=`ifconfig eth0 | perl -n -e 'if (m/inet addr:([\d\.]+)/g) { print $1 }'`
echo "ganglia ui: http://$ipaddress/ganglia"

cd /opt/docker_common_scripts/
for f in *.sh; do . ./$f & done

service ganglia-monitor restart && gmetad restart && service apache2 restart

chef-client -d -i 20 -s 1 -c /etc/chef/client.rb -E "admin" -r "recipe[ganglia::ganglia-server]" -L /var/log/chef-client.log


echo "ganglia ui: http://$ipaddress/ganglia"
/usr/sbin/sshd -D


