docker stop `docker ps -a | cut -d " " -f 1-1`
docker rm `docker ps -a | cut -d " " -f 1-1`


docker run -d --name dns -v /var/run/docker.sock:/docker.sock phensley/docker-dns  --domain example.com



docker run -d -t -h master.example.com --name master --dns $(docker inspect -f '{{.NetworkSettings.IPAddress}}' dns) --dns-search example.com pti1/hadoopmaster
docker run -d -t -h slave1.example.com --name slave1 --dns $(docker inspect -f '{{.NetworkSettings.IPAddress}}' dns) --dns-search example.com pti1/hadoopslave
docker run -d -t -h slave2.example.com --name slave2 --dns $(docker inspect -f '{{.NetworkSettings.IPAddress}}' dns) --dns-search example.com pti1/hadoopslave
