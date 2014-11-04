FROM pti1/dnsbase
ADD proxy.sh /opt/docker_common_scripts/0_proxy.sh
RUN /opt/docker_common_scripts/0_proxy.sh

MAINTAINER "Patrick Hensley <spaceboy@indirect.com>"
ENTRYPOINT ["./dockerdns"]

