echo "starting dns"
docker stop dns
docker rm dns
docker run -d -t --name dns -h dns.example.com -v /etc/bind pti1/bind9:secondversion
sleep 5

echo "starting aptrepo"
docker stop aptrepo
docker rm aptrepo

docker run -d -t -h aptrepo.example.com --name aptrepo --dns $(docker inspect -f '{{.NetworkSettings.IPAddress}}' dns) --dns-search example.com --link dns:dns --volumes-from dns   pti1/aptweb_server:secondversion



#echo "starting reprepro"
#docker stop reprepro
#docker rm reprepro

#docker run -d -t -h reprepro.example.com --name reprepro --dns $(docker inspect -f '{{.NetworkSettings.IPAddress}}' dns) --dns-search example.com --link dns:dns --volumes-from dns   pti1/reprepro_server:secondversion



echo "starting ansible server"

docker stop ansibleserver
docker rm ansibleserver
docker run -d -t --name ansibleserver -h ansibleserver.example.com --dns $(docker inspect -f '{{.NetworkSettings.IPAddress}}' dns) --dns-search example.com --link dns:dns --volumes-from dns -v /GIT/af/ansible/Playbooks:/playbooks pti1/ansibleserver:secondversion /opt/startup.sh --isproxy=false


docker stop hadoopmaster
docker rm hadoopmaster
docker run -d -t --name hadoopmaster -h hadoopmaster.example.com --dns $(docker inspect -f '{{.NetworkSettings.IPAddress}}' dns) --dns-search example.com --link dns:dns --volumes-from dns  --volumes-from ansibleserver pti1/aptweb_client:secondversion /opt/startup.sh --isproxy=false


docker stop hadoopslave1
docker rm hadoopslave1
docker run -d -t --name hadoopslave1 -h hadoopslave1.example.com --dns $(docker inspect -f '{{.NetworkSettings.IPAddress}}' dns) --dns-search example.com --link dns:dns --volumes-from dns  --volumes-from ansibleserver pti1/aptweb_client:secondversion /opt/startup.sh --isproxy=false

docker stop hadoopslave2
docker rm hadoopslave2
docker run -d -t --name hadoopslave2 -h hadoopslave2.example.com --dns $(docker inspect -f '{{.NetworkSettings.IPAddress}}' dns) --dns-search example.com --link dns:dns --volumes-from dns  --volumes-from ansibleserver pti1/aptweb_client:secondversion /opt/startup.sh --isproxy=false

docker stop gangliaserver
docker rm gangliaserver
docker run -d -t --name gangliaserver -h gangliaserver.example.com --dns $(docker inspect -f '{{.NetworkSettings.IPAddress}}' dns) --dns-search example.com --link dns:dns --volumes-from dns  --volumes-from ansibleserver pti1/aptweb_client:secondversion /opt/startup.sh --isproxy=false

