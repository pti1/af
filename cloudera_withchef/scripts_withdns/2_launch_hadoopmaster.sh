
#start hadoop master
docker run --privileged -d -t --name hadoopmaster -h hadoopmaster.example.com --link chefserver:chefserver --volumes-from chefserver --dns $(docker inspect -f '{{.NetworkSettings.IPAddress}}' dns) --dns-search example.com pti1/hadoopmaster_chef
