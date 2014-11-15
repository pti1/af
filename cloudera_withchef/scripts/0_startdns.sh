docker stop dns
docker rm dns
docker run -d -t --name dns -h dns.example.com -v /etc/bind -p 172.17.42.1:53:53/udp pti1/bind9:secondversion


