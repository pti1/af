docker stop hadoopslave2
docker rm hadoopslave2
docker exec chefserver knife client delete hadoopslave2.example.com -y
docker exec chefserver knife node delete hadoopslave2.example.com -y
docker run -d -t -h hadoopslave2.example.com --name hadoopslave2 --dns $(docker inspect -f '{{.NetworkSettings.IPAddress}}' dns) --dns-search example.com --link dns:dns --volumes-from dns --link chefserver:chefserver --volumes-from chefserver  pti1/hadoopslave_chef:secondversion


