# MapR single node cluster setup
#  - This has all the processes necessary to have a MapR server up 
#    and running to be able to load and process data
#
# General instructions: http://doc.mapr.com/display/MapR/Installing+MapR+Software
# 
# VERSION	1.0

#
# Using ubuntu as the base image as it is more typically used in a desktop environment
#
FROM ubuntu:14.04

MAINTAINER PTI PTI, pti@coco.fr

#
# Add necessary repos for installation
# http://doc.mapr.com/display/MapR/Installing+MapR+Software#InstallingMapRSoftware-mapr_repo
#

ENV DEBIAN_FRONTEND noninteractive
RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections


ADD proxy.sh /opt/docker_common_scripts/0_proxy.sh
RUN /opt/docker_common_scripts/0_proxy.sh


RUN apt-get update 
RUN apt-get install -q -y --force-yes wget curl inetutils-ping telnet git
RUN apt-get install -q -y --force-yes net-tools vim htop
#RUN apt-get install -y apt-utils python-software-properties software-properties-common
#RUN apt-add-repository -y ppa:ansible/ansible
#RUN apt-get install -y ansible
#RUN apt-get install -q -y --force-yes python-pip
#RUN pip install ansible
RUN apt-get install -q -y --force-yes python python-yaml python-paramiko python-jinja2 python-httplib2  build-essential

RUN git clone https://github.com/ansible/ansible.git
RUN apt-get install -q -y --force-yes python-setuptools
RUN cd ansible && make && sudo make install


# THIS IS TO GET SSH
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:root' |chpasswd

ADD startup.sh /opt/
CMD ["/opt/startup.sh"]


EXPOSE 22
