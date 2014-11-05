# start chef server
docker run -d --name dns -v /var/run/docker.sock:/docker.sock pti1/dns:initialversion  --domain example.com



