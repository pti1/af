#!/bin/bash

source ./common.sh

check_usage $# 1 "Usage: $0 <NUMBER OF NODES>"

NODES=$1
BRIDGE=br1


for id in $(seq 1 $NODES); do

	echo "Starting node $id/$NODES"
	hostname="host$id"
	ip=192.168.100.$id

	# start container
	if [[ $id == 1 ]]; then
		image="pti1/hadoopmaster"
	else
		image="pti1/hadoopslave"
	fi
	cid=$(sudo docker run -d --dns 127.0.0.1 --name $hostname -h $hostname -t  $image)

	# Add network interface
	sleep 1
	./pipework $BRIDGE $cid $ip/24
done
