sysctl -w kernel.shmall=4194304 
sysctl -w kernel.shmmax=17179869184
sysctl -p /etc/sysctl.conf 
#docker build --no-cache=false -t pti1/chefserver .
docker build  -t pti1/chefserver .
