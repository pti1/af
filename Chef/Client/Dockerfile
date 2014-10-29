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
FROM ubuntu:12.04

MAINTAINER PTI PTI, pti@coco.fr

#
# Add necessary repos for installation
# http://doc.mapr.com/display/MapR/Installing+MapR+Software#InstallingMapRSoftware-mapr_repo
#

ENV DEBIAN_FRONTEND noninteractive
RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d

RUN echo 'Acquire::http::Proxy "http://192.168.0.21:8080";' > /etc/apt/apt.conf.d/proxy
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
ENV http_proxy http://192.168.0.21:8080/
ENV https_proxy http://192.168.0.21:8080/


RUN apt-get update 
RUN apt-get install -q -y --force-yes wget curl inetutils-ping telnet git
RUN apt-get install -q -y --force-yes net-tools vim htop


RUN apt-get install -y apt-utils


# THIS IS TO GET SSH
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:root' |chpasswd

# install chef-client
RUN apt-get -yqq update \
  && apt-get -yqq install curl build-essential libxml2-dev libxslt-dev git autoconf

RUN curl -L https://www.opscode.com/chef/install.sh \
  | bash > /dev/null
  
RUN /opt/chef/embedded/bin/gem install berkshelf > /dev/null



EXPOSE 22 403 
