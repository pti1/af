docker stop dns
docker rm dns
docker run -d -t --name dns pti1/bind9:initialversion
