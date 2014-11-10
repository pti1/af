FROM ubuntu:12.04

ENV DEBIAN_FRONTEND noninteractive
RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d && \
echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections


ADD proxy.sh /opt/docker_common_scripts/0_proxy.sh
RUN /opt/docker_common_scripts/0_proxy.sh

RUN apt-get update && apt-get -y upgrade


RUN apt-get install -q -y --force-yes wget curl inetutils-ping telnet git net-tools vim htop apt-utils 

# install bind9
RUN apt-get install -q -y --force-yes bind9 dnsutils bind9utils


ADD named.conf* /etc/bind/
ADD db.example /etc/bind/
ADD db.172 /etc/bind/
EXPOSE 53

RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:root' |chpasswd

#configure bind9
# https://www.erianna.com/nsupdate-dynamic-dns-updates-with-bind9
RUN ln -s /var/lib/bind /etc/bind/zones
RUN cd /etc/bind && dnssec-keygen -a HMAC-MD5 -b 128 -n HOST example.com. 
ADD configurebind9.sh /etc/bind/
RUN /etc/bind/configurebind9.sh
RUN chmod -R 640 /etc/bind/Kexample.com*

ADD nsupdate.sh /opt/docker_common_scripts/nsupdate.sh

#EXPOSE 80 3306

ADD startup.sh /opt/
CMD ["/opt/startup.sh"]


