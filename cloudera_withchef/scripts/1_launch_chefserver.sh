# start chef server
docker stop chefserver
docker rm chefserver
docker run --privileged -d -t -h chefserver.example.com --name chefserver --dns $(docker inspect -f '{{.NetworkSettings.IPAddress}}' dns) --dns-search example.com --link dns:dns --volumes-from dns -v /GIT/af/opscode-chef-repo:/chef-repo -v /etc/chef-server pti1/chefserver:secondversion

