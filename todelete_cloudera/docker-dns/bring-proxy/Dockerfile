FROM python:2.7.8
ADD proxy.sh /opt/docker_common_scripts/0_proxy.sh
RUN /opt/docker_common_scripts/0_proxy.sh

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
ONBUILD COPY requirements.txt /usr/src/app/
ONBUILD RUN pip install --proxy http://192.168.0.21:8080/ -r requirements.txt
ONBUILD COPY . /usr/src/app


