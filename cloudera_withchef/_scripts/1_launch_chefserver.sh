# start chef server
docker run --privileged -d -t --name chefserver -h chefserver -v /GIT/af/opscode-chef-repo:/chef-repo -v /etc/chef-server pti1/chefserver

