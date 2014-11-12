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

ADD common_scripts/*build* /opt/docker_common_scripts/
RUN /opt/docker_common_scripts/1_launchbuild.sh


# install core packages
RUN apt-get update
RUN apt-get install -q -y --force-yes wget curl inetutils-ping telnet net-tools vim htop dnsutils apt-utils git cron mc

RUN apt-get install -q -y --force-yes openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:root' |chpasswd


# provide cron
ADD crontab /etc/

ADD common_scripts/* /opt/docker_common_scripts/

# provide run scripts : it does not need to be in other docker files
# since script 2_launchrun is generic
# it also register crons by executing 3_launchcron_run.sh
RUN echo "#!/bin/bash" > /etc/rc.local && \
echo "/opt/docker_common_scripts/2_launchrun.sh \$@" >> /etc/rc.local && \
echo "exit 0" >> /etc/rc.local


ADD startup.sh /opt/
CMD ["/opt/startup.sh"]


EXPOSE 22 403 
