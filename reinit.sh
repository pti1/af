#!/usr/bin/env bash

declare -a files=('4_proxy_buildrun.sh');
declare -a pathfiles=('/GIT/af/base/common_scripts/4_proxy_buildrun.sh');


i=0
for f in "${files[@]}"
do
  echo $i
  for aF in `find /GIT/af -name $f` 
  do
    orig="${pathfiles[$i]}"

    if [ "$orig" != "$aF" ]; then
      cp $orig $aF
      #echo "kiki"
    fi
    
    
  done
  let "i += 1"
done
