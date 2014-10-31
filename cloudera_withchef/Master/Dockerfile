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
FROM pti1/chefclient

MAINTAINER PTI PTI, pti@coco.fr

RUN apt-get install -y openjdk-7-jdk
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

RUN echo "deb [arch=amd64] http://archive.cloudera.com/cdh5/ubuntu/precise/amd64/cdh precise-cdh5 contrib" > /etc/apt/sources.list.d/cloudera.list

RUN echo "deb-src http://archive.cloudera.com/cdh5/ubuntu/precise/amd64/cdh precise-cdh5 contrib" >> /etc/apt/sources.list.d/clouderasrc.list

RUN echo "curl -s http://archive.cloudera.com/cdh5/ubuntu/precise/amd64/cdh/archive.key | apt-key add -"

RUN apt-get update

RUN apt-get install -q -y --force-yes hadoop-yarn-resourcemanager hadoop-hdfs-namenode 
RUN apt-get install -q -y --force-yes hadoop-yarn-nodemanager hadoop-hdfs-datanode hadoop-mapreduce


ADD core-site.xml /etc/hadoop/conf.empty/
ADD startup.sh /opt/

RUN su -c "hdfs namenode -format" hdfs

CMD ["/opt/startup.sh"]

EXPOSE 7180 7183 7182 7432 50020 50070 50010 50075 8040 8042 47314 13562 8030 8031 46664 57299 53686 50176 38904
EXPOSE 1004 1006 8020 50470 50090 50495 8485 8480 8032 8033 8088 8041 10020 19888  9160 9042

ADD yarn-site.xml /etc/hadoop/conf.empty/
ADD mapred-site.xml /etc/hadoop/conf.empty/
