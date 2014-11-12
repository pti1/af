#!/bin/bash

echo "run without dns"
docker stop kiki
docker rm kiki

docker run -d -t --name kiki -h kiki.example.com  pti1/base:secondversion /opt/startup.sh --isproxy=false


echo "run withdns"
docker stop kiki1
docker rm kiki1

docker run -d -t --name kiki1 -h kiki1.example.com --dns $(docker inspect -f '{{.NetworkSettings.IPAddress}}' dns) --dns-search example.com --link dns:dns --volumes-from dns pti1/base:secondversion /opt/startup.sh --isproxy=false

