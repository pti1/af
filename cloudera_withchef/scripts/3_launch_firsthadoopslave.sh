docker stop hadoopslave1
docker rm hadoopslave1
docker exec chefserver knife client delete hadoopslave1.example.com -y
docker exec chefserver knife node delete hadoopslave1.example.com -y
docker run -d -t -h hadoopslave1.example.com --name hadoopslave1 --dns $(docker inspect -f '{{.NetworkSettings.IPAddress}}' dns) --dns-search example.com --link dns:dns --volumes-from dns --link chefserver:chefserver --volumes-from chefserver  pti1/hadoopslave_chef:secondversion


