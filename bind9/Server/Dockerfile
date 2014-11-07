FROM ubuntu:12.04

ENV DEBIAN_FRONTEND noninteractive
RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections


ADD proxy.sh /opt/docker_common_scripts/0_proxy.sh
RUN /opt/docker_common_scripts/0_proxy.sh

RUN apt-get update
RUN apt-get -y upgrade


RUN apt-get install -q -y --force-yes wget curl inetutils-ping telnet git
RUN apt-get install -q -y --force-yes net-tools vim htop


RUN apt-get install -y apt-utils



RUN apt-get install -q -y --force-yes bind9 dnsutils bind9utils


ADD named.conf /etc/bind/named.conf
ADD named.conf.options /etc/bind/named.conf.options
ADD named.conf.docker /etc/bind/named.conf.docker
ADD named.conf.local /etc/bind/named.conf.local
EXPOSE 53
VOLUME /data

RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:root' |chpasswd

#configure bind9
RUN ln -s /var/lib/bind /etc/bind/zones
RUN cd /tmp && dnssec-keygen -a HMAC-MD5 -b 128 -n HOST example.com. 
RUN kiki=`more /tmp/*example*.key | cut -d ' ' -f 7` && echo $titi > /tmp/poof
RUN chmod -R 640 /tmp/Kexample.com*


#bind9 gui
#VOLUME ["/var/lib/mysql"]
#VOLUME ["/run/mysqld"]
#VOLUME ["/var/run/mysqld"]
#RUN apt-get install -q -y --force-yes smbind
#EXPOSE 80 3306

ADD startup.sh /opt/
CMD ["/opt/startup.sh"]


