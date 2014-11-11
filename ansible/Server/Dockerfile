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
#FROM ubuntu:14.04

FROM pti1/base:secondversion


MAINTAINER PTI PTI, pti@coco.fr

RUN apt-get update && \
 apt-get install -q -y --force-yes build-essential && \
 apt-get install -q -y --force-yes python-pip python-dev git -y && \
 pip install PyYAML jinja2 paramiko && \
 git clone https://github.com/ansible/ansible.git && \
 cd ansible && \
 make install && \
 mkdir /etc/ansible 

ADD startup.sh /opt/
CMD ["/opt/startup.sh"]


EXPOSE 22
