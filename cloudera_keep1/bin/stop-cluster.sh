#!/bin/bash

source ./common.sh

#check_usage $# 1 "Usage: $0"

IMAGE=hadoop


if docker ps | grep $IMAGE >/dev/null; then
	cids=$(sudo docker ps | grep $IMAGE | awk '{ print $1 }')
	echo $cids | xargs echo "Killing and removing containers"
	sudo docker kill $cids > /dev/null
	sudo docker rm $cids   > /dev/null
fi
