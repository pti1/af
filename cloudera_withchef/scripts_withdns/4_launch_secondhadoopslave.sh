
#start hadoop master
docker run  --privileged -d -t --name hadoopslave2 -h hadoopslave2.example.com --link chefserver:chefserver --volumes-from chefserver --dns $(docker inspect -f '{{.NetworkSettings.IPAddress}}' dns) --dns-search example.com pti1/hadoopslave_chef:initialversion
