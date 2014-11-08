#!/usr/bin/env bash


 
ipaddress=`ifconfig eth0 | perl -n -e 'if (m/inet addr:([\d\.]+)/g) { print $1 }'`
echo "dns ui: https://$ipaddress"



#/usr/sbin/named -c /etc/bind/named.conf -f
#service bind9 restart
#CMD ["/usr/sbin/named", "-c", "/etc/bind/named.conf", "-f"]

named -d 5 

/opt/docker_common_scripts/nsupdate.sh >/var/log/dns.log&

echo "dns ip: $ipaddress"
echo "to restart dns: service bind9 restart"
echo "to see logs: stop service bind, then run 'named -d 7', logs are in /var/cache/bind/named.run"
echo "to check conf: named-checkconf"


/usr/sbin/sshd -D




