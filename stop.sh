docker stop `docker ps -a | cut -d " " -f 1-1`
docker rm `docker ps -a | cut -d " " -f 1-1`
