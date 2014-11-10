#!/bin/bash

dockerid=`cat  /proc/self/cgroup | grep docker | head -1 | sed "s/.*docker\///g"`
echo $dockerid

#memory

for aMemMetric in `more /opt/metrics/memory/docker/$dockerid/memory.stat`
do
  echo "pti: $aMemMetric"

done

