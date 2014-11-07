#!/usr/bin/env bash


 
ipaddress=`ifconfig eth0 | perl -n -e 'if (m/inet addr:([\d\.]+)/g) { print $1 }'`
echo "dns ui: https://$ipaddress"



#/usr/sbin/named -c /etc/bind/named.conf -f
service bind9 restart
#CMD ["/usr/sbin/named", "-c", "/etc/bind/named.conf", "-f"]
echo "dns ui: http://$ipaddress/smbind"


/usr/sbin/sshd -D




