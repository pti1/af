#!/usr/bin/env bash

cd /opt/docker_common_scripts/
for f in *.sh; do . ./$f; done

ipaddress=`ifconfig eth0 | perl -n -e 'if (m/inet addr:([\d\.]+)/g) { print $1 }'`
echo "cloudstack ui: http://$ipaddress:8080/client"
echo "user is admin, passw=password"

/usr/sbin/sshd -D&



service mysql restart
cd /opt/cloudstack
mvn -o -pl client jetty:run -Dsimulator&


ipaddress=`ifconfig eth0 | perl -n -e 'if (m/inet addr:([\d\.]+)/g) { print $1 }'`
echo "cloudstack ui: http://$ipaddress:8080/client"


/usr/sbin/sshd -D
