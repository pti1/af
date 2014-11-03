#!/usr/bin/env bash

cd /opt/docker_common_scripts/
for f in *.sh; do . ./$f; done


service mysql restart
cd /opt/cloudstack
mvn -pl client jetty:run -Dsimulator


ipaddress=`ifconfig eth0 | perl -n -e 'if (m/inet addr:([\d\.]+)/g) { print $1 }'`
echo "cloudstack ui: https://$ipaddress:8080"


/usr/sbin/sshd -D
