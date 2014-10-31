# start chef server
docker run --privileged -d -t --name chefserver -h chefserver -v /GIT/hortonworks/opscode-chef-repo:/chef-repo -v /etc/chef-server pti1/chefserver

#start chef client
docker run -d -t --name client1 -h client1 --link chefserver:chefserver --volumes-from chefserver pti1/chefclient
#docker run -i -t -h client1 --link chefserver:chefserver  pti1/chefclient /bin/bash
