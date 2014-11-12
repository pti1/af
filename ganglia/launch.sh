#!/bin/bash

echo "launch chef client"
docker stop kiki
docker rm kiki

docker exec chefserver knife client delete kiki.example.com -y
docker exec chefserver knife node delete kiki.example.com -y


docker run -d -t --name kiki -h kiki.example.com  --dns $(docker inspect -f '{{.NetworkSettings.IPAddress}}' dns) --dns-search example.com --link dns:dns --volumes-from dns --link chefserver:chefserver --volumes-from chefserver pti1/gangliaserver:secondversion 

