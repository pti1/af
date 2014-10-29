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
FROM pti1/chefbase

MAINTAINER PTI PTI, pti@coco.fr

#
# Add necessary repos for installation
# http://doc.mapr.com/display/MapR/Installing+MapR+Software#InstallingMapRSoftware-mapr_repo
#

RUN apt-get -y install curl build-essential libxml2-dev libxslt-dev git

ADD chef-server-core_12.0.0-rc.5-1_amd64.deb /opt/
#ADD run.sh /opt/

RUN dpkg -i /opt/chef-server-core_12.0.0-rc.5-1_amd64.deb

RUN	dpkg-divert --local --rename --add /sbin/initctl
RUN	ln -sf /bin/true /sbin/initctl

#RUN sysctl -w kernel.shmall=4194304
#RUN sysctl -w kernel.shmmax=17179869184

RUN ls -a
RUN cat /proc/sys/kernel/shmall
RUN cat /proc/sys/kernel/shmmax

#RUN    /opt/chef-server/embedded/bin/runsvdir-start & \
#    chef-server-ctl reconfigure && \
#    chef-server-ctl stop

#CMD	["/opt/run.sh"]

#RUN curl -L https://www.opscode.com/chef/install.sh | bash
#RUN echo "gem: --no-ri --no-rdoc" > ~/.gemrc
#RUN /opt/chef/embedded/bin/gem install berkshelf



EXPOSE 443
