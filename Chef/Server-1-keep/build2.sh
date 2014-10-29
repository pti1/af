docker run -i -t --privileged=true pti1/chefserver /bin/bash

#puis à la main dedans le container
sysctl -w kernel.shmall=4194304 
sysctl -w kernel.shmmax=17179869184
sysctl -p /etc/sysctl.conf 
chef-server-ctl reconfigure

# sortir du container

docker commit <imageid> pti1/chefserverconfigured

