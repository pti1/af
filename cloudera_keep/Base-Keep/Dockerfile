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


RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d

RUN echo 'Acquire::http::Proxy "http://192.168.0.21:8080";' > /etc/apt/apt.conf.d/proxy
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
ENV http_proxy http://192.168.0.21:8080/


RUN echo "deb [arch=amd64] http://archive.cloudera.com/cdh5/ubuntu/precise/amd64/cdh precise-cdh5 contrib" > /etc/apt/sources.list.d/cloudera.list

RUN echo "deb-src http://archive.cloudera.com/cdh5/ubuntu/precise/amd64/cdh precise-cdh5 contrib" >> /etc/apt/sources.list.d/clouderasrc.list

RUN echo "curl -s http://archive.cloudera.com/cdh5/ubuntu/precise/amd64/cdh/archive.key | apt-key add -"

#
# Install all of the core portions of MapR in order to create a single node "cluster"
# http://doc.mapr.com/display/MapR/Installing+MapR+Software#InstallingMapRSoftware-InstallationInstallation
#
RUN apt-get update 
RUN apt-get install -q -y --force-yes wget curl inetutils-ping telnet
RUN apt-get install -q -y --force-yes net-tools vim
#RUN wget -O - http://package.mapr.com/releases/pub/maprgpg.key |  apt-key add -


# install java
# Install Java.
RUN apt-get install -y openjdk-7-jdk
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

RUN apt-get install -y apt-utils

RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:root' |chpasswd


EXPOSE 22
