FROM pti1/base:secondversion
#FROM debian:wheezy
MAINTAINER pti1 <pti1@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

ADD common_scripts/*build* /opt/docker_common_scripts/
RUN /opt/docker_common_scripts/1_launchbuild.sh

RUN rm -f /etc/apt/apt.conf.d/docker-clean


RUN apt-get update && \
 apt-get install -yq --no-install-recommends aptitude apache2 && \
 mkdir /var/www/debian && \
 mv /var/cache/apt/archives/*.deb /var/www/debian

RUN apt-get install -q -y --force-yes ganglia-monitor rrdtool gmetad ganglia-webfrontend  && \
     mv /var/cache/apt/archives/*.deb /var/www/debian

# cloudera
RUN echo "deb [arch=amd64] http://archive.cloudera.com/cdh5/ubuntu/precise/amd64/cdh precise-cdh5 contrib" > /etc/apt/sources.list.d/cloudera.list && \
 echo "deb-src http://archive.cloudera.com/cdh5/ubuntu/precise/amd64/cdh precise-cdh5 contrib" >> /etc/apt/sources.list.d/clouderasrc.list && \
 apt-get update && \
 apt-get install -q -y --force-yes hadoop-yarn-resourcemanager hadoop-hdfs-namenode hadoop-yarn-nodemanager hadoop-hdfs-datanode hadoop-mapreduce && \
 mv /var/cache/apt/archives/*.deb /var/www/debian

# java
RUN apt-get install -q -y --force-yes openjdk-7-jdk && \
  mv /var/cache/apt/archives/*.deb /var/www/debian

# python-apt
RUN apt-get install -q -y --force-yes python-apt && \
  mv /var/cache/apt/archives/*.deb /var/www/debian

# spark
RUN apt-get install -q -y --force-yes spark-core spark-worker spark-master spark-python spark-history-server hadoop-client && \ 
  mv /var/cache/apt/archives/*.deb /var/www/debian


RUN cd /var/www && \
 apt-get install -y dpkg-dev && \
 dpkg-scanpackages debian /dev/null | gzip -9c > debian/Packages.gz 


ADD common_scripts/* /opt/docker_common_scripts/

ADD startup.sh /opt/
CMD ["/opt/startup.sh"]

    
