# start chef server
docker run --privileged -d -t --name chefserver -h chefserver -v /etc/chef pti1/chefserver

#start chef client
docker run -i -t -h client1 --link chefserver:chefserver --volumes-from chefserver pti1/chefclient /bin/bash
#docker run -i -t -h client1 --link chefserver:chefserver  pti1/chefclient /bin/bash
