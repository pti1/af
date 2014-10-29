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

MAINTAINER Jim Scott, jscott@mapr.com

#
# Add necessary repos for installation
# http://doc.mapr.com/display/MapR/Installing+MapR+Software#InstallingMapRSoftware-mapr_repo
#

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN echo "deb http://package.mapr.com/releases/v4.0.0-FCS/ubuntu mapr optional" > /etc/apt/sources.list.d/mapr.list
RUN echo "deb http://package.mapr.com/releases/ecosystem/ubuntu binary/" >> /etc/apt/sources.list.d/mapr.list
#RUN apt-get install -q -y --force-yes gwget
#RUN wget -O - http://package.mapr.com/releases/pub/maprgpg.key |  apt-key add -
RUN echo 'Acquire::http::Proxy "http://192.168.0.21:8080";' > /etc/apt/apt.conf.d/proxy

#
# Install all of the core portions of MapR in order to create a single node "cluster"
# http://doc.mapr.com/display/MapR/Installing+MapR+Software#InstallingMapRSoftware-InstallationInstallation
#
RUN apt-get update 
RUN apt-get install -q -y --force-yes wget
RUN apt-get install -q -y --force-yes net-tools vim
#RUN wget -O - http://package.mapr.com/releases/pub/maprgpg.key |  apt-key add -


# install java
# Install Java.
RUN apt-get install -y openjdk-7-jdk
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64


RUN apt-get -q -y --force-yes install mapr-cldb 

RUN apt-get -q -y --force-yes install mapr-jobtracker mapr-webserver mapr-fileserver mapr-metrics mapr-nfs mapr-tasktracker mapr-zookeeper

# configure platform
# http://doc.mapr.com/display/MapR/Installing+MapR+Software#InstallingMapRSoftware-configure-nodeConfiguretheNodewiththeconfigure.shScript
# http://doc.mapr.com/display/MapR/Installing+MapR+Software#InstallingMapRSoftware-ConfiguringClusterStoragewiththedisksetupScript
#
# configure.sh
# disksetup
#

#
# Start services
# http://doc.mapr.com/display/MapR/Bringing+Up+the+Cluster
#
#CMD ["service", "mapr-zookeeper", "start]
#ENTRYPOINT ["service", "mapr-warden", "start"]

#USER mapr

#
# Expose all the ports from this container that are necessary for proper communication to a Hadoop cluster
#

#
# WebServer CLDB ZooKeeper
#
EXPOSE 8443 7222 5181


# Add documentation here for how to add a license
# maprcli license add [ -cluster <name> ] -license <filename> -is_file true
