docker stop master
docker rm master
docker run -d -t -h master --name master pti1/hadoopmaster

#pipework/pipework br1 master 192.168.1.1/24
docker stop slave1
docker rm slave1

docker run -d  -t -h slave1 --name slave1  pti1/hadoopslave
#pipework/pipework br1 master 192.168.1.2/24


