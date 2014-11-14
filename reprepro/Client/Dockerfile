FROM pti1/base:secondversion
#FROM debian:wheezy
MAINTAINER pti1 <pti1@gmail.com>

RUN /opt/docker_common_scripts/1_launchbuild.sh --noproxy=true

RUN rm -f /etc/apt/sources.list && \
    rm -f /etc/apt/sources.list.d/* && \
    echo "deb [arch=amd64] http://reprepro.example.com/ubuntu precise main" > /etc/apt/sources.list.d/reprepro.list && \
    echo "deb-src http://reprepro.example.com/ubuntu precise main" >> /etc/apt/sources.list.d/reprepro.list 

ADD common_scripts/* /opt/docker_common_scripts/
#CMD ["apt-get update && /opt/startup.sh --isproxy=false"]

