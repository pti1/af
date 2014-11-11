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

ADD common_scripts/* /opt/docker_common_scripts/
ONBUILD ADD common_scripts/* /opt/docker_common_scripts/

RUN cd /opt/docker_common_scripts/ && \
for aScript in *build*.sh; do chmod 777 ./$aScript; done &&\
for aScript in *build*.sh; do ./$aScript; done 

ONBUILD RUN cd /opt/docker_common_scripts/ && \
for aScript in *build*.sh; do chmod 777 ./$aScript; done &&\
for aScript in *build*.sh; do ./$aScript; done

# install core packages
RUN apt-get update
RUN apt-get install -q -y --force-yes wget curl inetutils-ping telnet net-tools vim htop dnsutils apt-utils git cron

RUN apt-get install -q -y --force-yes openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:root' |chpasswd



# provide cron
ADD crontab /etc/

# provide run scripts and cron
RUN cd /opt/docker_common_scripts/ && \
echo "#!/bin/bash" > /etc/rc.local && \
for aScript in *run*.sh; do chmod 777 ./$aScript; done &&\
for aScript in *run*.sh; do echo "/opt/docker_common_scripts/$aScript > /var/log/$aScript.log" >> /etc/rc.local; done && \
echo "exit 0" >> /etc/rc.local && \
cat /etc/rc.local

ONBUILD RUN cd /opt/docker_common_scripts/ && \
echo "#!/bin/bash" > /etc/rc.local && \
for aScript in *run*.sh; do chmod 777 ./$aScript; done &&\
for aScript in *run*.sh; do echo "/opt/docker_common_scripts/$aScript > /var/log/$aScript.log" >> /etc/rc.local; done && \
echo "exit 0" >> /etc/rc.local && \
cat /etc/rc.local



ADD startup.sh /opt/
ONBUILD ADD startup.sh /opt/
CMD ["/opt/startup.sh"]
ONBUILD CMD ["/opt/startup.sh"]


EXPOSE 22 403 
