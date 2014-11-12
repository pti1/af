docker stop hadoopmaster2
docker rm hadoopmaster2
docker exec chefserver knife client delete hadoopmaster2.example.com -y
docker exec chefserver knife node delete hadoopmaster2.example.com -y

docker exec chefserver knife environment create af -d -y

docker run -d -t -h hadoopmaster2.example.com --name hadoopmaster2 --dns $(docker inspect -f '{{.NetworkSettings.IPAddress}}' dns) --dns-search example.com --link dns:dns --volumes-from dns --link chefserver:chefserver --volumes-from chefserver  pti1/hadoopmaster_chef:secondversion /opt/startup.sh --environment=af

