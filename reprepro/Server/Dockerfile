FROM pti1/base:secondversion
#FROM debian:wheezy
MAINTAINER pti1 <pti1@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

ADD common_scripts/*build* /opt/docker_common_scripts/
RUN /opt/docker_common_scripts/1_launchbuild.sh


RUN apt-get update && \
 apt-get install -yq --no-install-recommends reprepro aptitude apache2 && \
 mkdir -p /var/packages/ubuntu/ && \
 mkdir /var/packages/ubuntu/conf && \
 mkdir -p /var/packages/debian/ && \
 mkdir /var/packages/debian/conf && \
 touch /var/packages/ubuntu/conf/override.precise

ADD distributions /var/packages/ubuntu/conf/
ADD options /var/packages/ubuntu/conf/

ADD loaddebs.sh /opt/

ADD apache-repo.conf  /etc/apache2/sites-available/repo 
RUN rm -f /etc/apache2/sites-enabled/000-default && \
 rm -f /etc/apache2/sites-available/default*

RUN apt-get install -yq gnupg dpkg-sig && mkdir /root/.gnupg
ADD gpgkeys/.gnupg/* /root/.gnupg/


#ganglia
RUN aptitude -y --download-only install ganglia-monitor rrdtool gmetad ganglia-webfrontend && \
    mkdir -p /debs/ganglia && \
    mv /var/cache/apt/archives/* /debs/ganglia && \
    cd /opt/ && ./loaddebs.sh /debs/ganglia

# cloudera
RUN echo "deb [arch=amd64] http://archive.cloudera.com/cdh5/ubuntu/precise/amd64/cdh precise-cdh5 contrib" > /etc/apt/sources.list.d/cloudera.list && \
 echo "deb-src http://archive.cloudera.com/cdh5/ubuntu/precise/amd64/cdh precise-cdh5 contrib" >> /etc/apt/sources.list.d/clouderasrc.list && \
 apt-get update && \
 yes Yes | aptitude -y --download-only install hadoop-yarn-resourcemanager hadoop-hdfs-namenode hadoop-yarn-nodemanager hadoop-hdfs-datanode hadoop-mapreduce && \
 mkdir -p /debs/hadoop && \
 mv /var/cache/apt/archives/* /debs/hadoop && \
 cd /opt/ && ./loaddebs.sh /debs/hadoop

# java
RUN aptitude -y --download-only install openjdk-7-jdk && \
    mkdir -p /debs/java && \
    mv /var/cache/apt/archives/* /debs/java && \
    cd /opt/ && ./loaddebs.sh /debs/java



ADD common_scripts/* /opt/docker_common_scripts/

ADD startup.sh /opt/
CMD ["/opt/startup.sh"]

    
