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

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

ADD proxy.sh /opt/docker_common_scripts/0_proxy.sh
RUN /opt/docker_common_scripts/0_proxy.sh


RUN apt-get update
RUN apt-get install -q -y --force-yes wget curl

RUN curl -L https://www.opscode.com/chef/install.sh | bash 
  

ADD 1_chefclient.sh /opt/docker_common_scripts/
ADD startup.sh /opt/
CMD ["/opt/startup.sh"]


EXPOSE 22 403 
