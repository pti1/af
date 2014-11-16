docker stop anotherclient
docker rm anotherclient
docker exec chefserver knife client delete anotherclient.example.com -y
docker exec chefserver knife node delete anotherclient.example.com -y

#docker exec chefserver knife environment create af -d -y

docker run -d -t -h anotherclient.example.com --name anotherclient --dns $(docker inspect -f '{{.NetworkSettings.IPAddress}}' dns) --dns-search example.com --link dns:dns --volumes-from dns --link chefserver:chefserver --volumes-from chefserver  pti1/chefclient:secondversion /opt/startup.sh --env=af --runlist="role[base-cloudera]"

