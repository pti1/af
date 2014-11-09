docker stop dns
docker rm dns
docker run -d -t --name dns -h dns.example.com -v /etc/bind pti1/bind9:secondversion

docker stop chefserver
docker rm chefserver
docker run --privileged -d -t -h chefserver.example.com --name chefserver --dns $(docker inspect -f '{{.NetworkSettings.IPAddress}}' dns) --dns-search example.com --link dns:dns --volumes-from dns -v /GIT/af/opscode-chef-repo:/chef-repo pti1/chefserver:secondversion


