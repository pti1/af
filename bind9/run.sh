docker stop dns
docker rm dns
docker run -d -t --name dns -h dns.example.com  pti1/bind9:secondversion
