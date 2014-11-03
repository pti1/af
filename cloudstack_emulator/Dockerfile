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
FROM runseb/cloudstack:0.1.4 
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



# THIS IS TO GET SSH
RUN apt-get install -y openssh-server
#RUN mkdir /var/run/sshd
RUN echo 'root:root' |chpasswd


EXPOSE 8080
EXPOSE 22
ADD run.sh /opt/
CMD ["/opt/run.sh"]
