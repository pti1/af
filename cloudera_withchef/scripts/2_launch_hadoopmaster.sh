docker stop hadoopmaster
docker rm hadoopmaster
docker run -d -t -h hadoopmaster.example.com --name hadoopmaster --dns $(docker inspect -f '{{.NetworkSettings.IPAddress}}' dns) --dns-search example.com --link dns:dns --volumes-from dns --link chefserver:chefserver --volumes-from chefserver  pti1/hadoopmaster_chef:secondversion

