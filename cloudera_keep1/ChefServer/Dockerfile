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
FROM pti1/base

MAINTAINER PTI PTI, pti@coco.fr

ADD startup.sh /opt/
ADD chef-server-core_12.0.0-rc.5-1_amd64.deb /opt/

RUN cd /opt && dpkg -i chef-server*.deb

RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl
ADD . /usr/local/bin/
EXPOSE 443


CMD ["/opt/startup.sh"]


