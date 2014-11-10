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
FROM pti1/chefclient:secondversion

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


# attention "service ganglia stop does not work"

RUN echo "deb http://ppa.launchpad.net/rufustfirefly/ganglia/ubuntu precise main" > /etc/apt/sources.list.d/ganglia.list
RUN echo "deb-src http://ppa.launchpad.net/rufustfirefly/ganglia/ubuntu precise main" >> /etc/apt/sources.list.d/ganglia.list

RUN apt-get update 
RUN apt-get install -q -y --force-yes rrdtool gmetad 

#RUN apt-get install -q -y --force-yes ganglia-webfrontend 
#RUN cp /etc/ganglia-webfrontend/apache.conf /etc/apache2/sites-enabled/ganglia.conf


# add ganglia web 2
ADD apache.conf /opt/
RUN git clone https://github.com/ganglia/ganglia-web.git && \
    cd ganglia-web && \
    make install && \
    apt-get install -q -y --force-yes apache2 libapache2-mod-php5 php5-gd rrdtool && \
    cp /opt/apache.conf /etc/apache2/sites-available/ganglia && \
    a2dissite default && a2ensite ganglia && service apache2 reload



ADD startup.sh /opt/
CMD ["/opt/startup.sh"]

EXPOSE 22 80
