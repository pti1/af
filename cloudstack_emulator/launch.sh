docker stop cloudstack
docker rm cloudstack
docker run -d -t --name cloudstack pti1/cloudstack:initialversion 
