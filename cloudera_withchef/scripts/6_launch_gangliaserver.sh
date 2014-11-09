docker stop gangliaservver
docker rm gangliaserver
docker run -d -t -h gangliaserver.example.com --name gangliaserver --dns $(docker inspect -f '{{.NetworkSettings.IPAddress}}' dns) --dns-search example.com --link dns:dns --volumes-from dns --link chefserver:chefserver --volumes-from chefserver  pti1/gangliaserver:secondversion

