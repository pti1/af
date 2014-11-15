docker stop dns
docker rm dns
docker run -d -t --name dns -h dns.example.com -v /etc/bind pti1/bind9:secondversion

docker stop reprepro
docker rm reprepro

docker run -d -t -h reprepro.example.com --name reprepro --dns $(docker inspect -f '{{.NetworkSettings.IPAddress}}' dns) --dns-search example.com --link dns:dns --volumes-from dns  --volume /GIT/af/reprepro:/kiki pti1/reprepro_server:secondversion /opt/startup.sh 

docker stop anotherclient
docker rm anotherclient

docker run -d -t -h anotherclient.example.com --name anotherclient --dns $(docker inspect -f '{{.NetworkSettings.IPAddress}}' dns) --dns-search example.com --link dns:dns --volumes-from dns  pti1/reprepro_client:secondversion
#--isproxy=true


