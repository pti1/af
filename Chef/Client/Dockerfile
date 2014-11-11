FROM pti1/base:secondversion

MAINTAINER PTI PTI, pti@coco.fr

# install chef-client
RUN apt-get install -q -y --force-yes build-essential libxml2-dev libxslt-dev  autoconf

RUN . /root/.bashrc && curl -L https://www.opscode.com/chef/install.sh | bash 
  
EXPOSE 22 403 
