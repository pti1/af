FROM pti1/base:secondversion

MAINTAINER PTI PTI, pti@coco.fr

ADD common_scripts/*build* /opt/docker_common_scripts/
RUN /opt/docker_common_scripts/1_launchbuild.sh


# install chef-client
RUN apt-get install -q -y --force-yes build-essential libxml2-dev libxslt-dev  autoconf

RUN . /root/.bashrc && curl -L https://www.opscode.com/chef/install.sh | bash 

ADD common_scripts/* /opt/docker_common_scripts/

ADD startup.sh /opt/
CMD ["/opt/startup.sh"]
  
EXPOSE 22 403 
