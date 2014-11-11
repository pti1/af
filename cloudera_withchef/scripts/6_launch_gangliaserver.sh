docker stop gangliaserver
docker rm gangliaserver
docker exec chefserver knife client delete gangliaserver.example.com -y
docker exec chefserver knife node delete gangliaserver.example.com -y

docker run -d -t -h gangliaserver.example.com --name gangliaserver --dns $(docker inspect -f '{{.NetworkSettings.IPAddress}}' dns) --dns-search example.com --link dns:dns --volumes-from dns --link chefserver:chefserver --volumes-from chefserver -v /sys/fs/cgroup:/opt/metrics  pti1/gangliaserver:secondversion /opt/startup.sh --interval=200 

