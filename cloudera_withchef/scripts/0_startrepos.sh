
echo "starting aptrepo"
docker stop aptrepo
docker rm aptrepo

docker run -d -t -h aptrepo.example.com --name aptrepo --dns $(docker inspect -f '{{.NetworkSettings.IPAddress}}' dns) --dns-search example.com --link dns:dns --volumes-from dns   pti1/aptweb_server:secondversion

