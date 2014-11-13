echo "starting dns"
docker stop dns
docker rm dns
docker run -d -t --name dns -h dns.example.com -v /etc/bind pti1/bind9:secondversion

echo "starting ansible server"

docker stop ansibleserver
docker rm ansibleserver
docker run -d -t --name ansibleserver -h ansibleserver.example.com --dns $(docker inspect -f '{{.NetworkSettings.IPAddress}}' dns) --dns-search example.com --link dns:dns --volumes-from dns -v /GIT/af/ansible/Playbooks:/playbooks pti1/ansibleserver:secondversion /opt/startup.sh --isproxy=false


docker stop hadoopmaster
docker rm hadoopmaster
docker run -d -t --name hadoopmaster -h hadoopmaster.example.com --dns $(docker inspect -f '{{.NetworkSettings.IPAddress}}' dns) --dns-search example.com --link dns:dns --volumes-from dns  --volumes-from ansibleserver pti1/base:secondversion /opt/startup.sh --isproxy=false

docker stop hadoopslave1
docker rm hadoopslave1
docker run -d -t --name hadoopslave1 -h hadoopslave1.example.com --dns $(docker inspect -f '{{.NetworkSettings.IPAddress}}' dns) --dns-search example.com --link dns:dns --volumes-from dns  --volumes-from ansibleserver pti1/base:secondversion /opt/startup.sh --isproxy=false

docker stop hadoopslave2
docker rm hadoopslave2
docker run -d -t --name hadoopslave2 -h hadoopslave2.example.com --dns $(docker inspect -f '{{.NetworkSettings.IPAddress}}' dns) --dns-search example.com --link dns:dns --volumes-from dns  --volumes-from ansibleserver pti1/base:secondversion /opt/startup.sh --isproxy=false

