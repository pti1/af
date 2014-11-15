FROM pti1/base:secondversion
#FROM debian:wheezy
MAINTAINER pti1 <pti1@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

ADD common_scripts/*build* /opt/docker_common_scripts/
RUN /opt/docker_common_scripts/1_launchbuild.sh


RUN apt-get update && \
 apt-get install -yq --no-install-recommends aptitude apache2 


#ADD apache-repo.conf  /etc/apache2/sites-available/repo 
#RUN rm -f /etc/apache2/sites-enabled/000-default && \
# rm -f /etc/apache2/sites-available/default*


#ganglia
RUN aptitude -y --download-only install ganglia-monitor rrdtool gmetad ganglia-webfrontend 

# cloudera
RUN echo "deb [arch=amd64] http://archive.cloudera.com/cdh5/ubuntu/precise/amd64/cdh precise-cdh5 contrib" > /etc/apt/sources.list.d/cloudera.list && \
 echo "deb-src http://archive.cloudera.com/cdh5/ubuntu/precise/amd64/cdh precise-cdh5 contrib" >> /etc/apt/sources.list.d/clouderasrc.list && \
 apt-get update && \
 yes Yes | aptitude -y --download-only install hadoop-yarn-resourcemanager hadoop-hdfs-namenode hadoop-yarn-nodemanager hadoop-hdfs-datanode hadoop-mapreduce 

# java
RUN aptitude -y --download-only install openjdk-7-jdk 

# python-apt
RUN aptitude -y --download-only install python-apt

RUN mkdir /var/www/debian && \
 mv /var/cache/apt/archives/* /var/www/debian && \
 cd /var/www && \
 apt-get install -y dpkg-dev && \
 dpkg-scanpackages debian /dev/null | gzip -9c > debian/Packages.gz 


ADD common_scripts/* /opt/docker_common_scripts/

ADD startup.sh /opt/
CMD ["/opt/startup.sh"]

    
