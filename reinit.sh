#!/usr/bin/env bash

declare -a files=('proxy.sh' 'nsupdate.sh');
declare -a pathfiles=('/GIT/af/proxy/proxy.sh' '/GIT/af/bind9/nsupdate.sh');


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
