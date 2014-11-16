docker stop dns
docker rm dns
docker run -d -t --name dns -h dns.example.com -v /etc/bind pti1/bind9:secondversion

docker stop aptrepo
docker rm aptrepo

docker run -d -t -h aptrepo.example.com --name aptrepo --dns $(docker inspect -f '{{.NetworkSettings.IPAddress}}' dns) --dns-search example.com --link dns:dns --volumes-from dns pti1/aptweb_server:secondversion

docker stop anotherclient
docker rm anotherclient

docker run -d -t -h anotherclient.example.com --name anotherclient --dns $(docker inspect -f '{{.NetworkSettings.IPAddress}}' dns) --dns-search example.com --link dns:dns --volumes-from dns  pti1/aptweb_client:secondversion
#--isproxy=true


