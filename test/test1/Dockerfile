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

#RUN apt-get install -y vim

#RUN echo 'Acquire::http::Proxy "http://192.168.0.222:8080";' > /etc/apt/apt.conf.d/proxy
#RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
#ENV http_proxy http://192.168.0.222:8080/


EXPOSE 22
