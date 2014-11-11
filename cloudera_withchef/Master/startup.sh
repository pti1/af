#!/usr/bin/env bash

# read the options
TEMP=`getopt -o i:s:e:r: --long interval:,spread:,env:,runlist: -n 'test.sh' -- "$@"`
eval set -- "$TEMP"

# extract options and their arguments into variables.
ARG_I='60'
ARG_S='10'
ARG_E='dev'
ARG_R='role[master-cloudera]'
while true ; do
    case "$1" in
        -i|--interval)
            case "$2" in
                *) ARG_I=$2 ; shift 2 ;;
            esac ;;
        -s|--spread)
            case "$2" in
                *) ARG_S=$2 ; shift 2 ;;
            esac ;;
       -e|--env)
            case "$2" in
                *) ARG_E=$2 ; shift 2 ;;
            esac ;;
       -r|--runlist)
            case "$2" in
                *) ARG_R=$2 ; shift 2 ;;
            esac ;;
        --) shift ; break ;;
        *) echo "Internal error!" ; exit 1 ;;
    esac
done

# do something with the variables -- in this case the lamest possible one :-)
echo "interval = $ARG_I"
echo "spread = $ARG_S"
echo "env = $ARG_E"
echo "runlist = $ARG_R"

ipaddress=`ifconfig eth0 | perl -n -e 'if (m/inet addr:([\d\.]+)/g) { print $1 }'`
echo "resourcemgr ui: http://$ipaddress:50070"
echo "node manager ui:http://$ipaddress:8042"
echo "yarn resource manager ui:http://$ipaddress:8088"

/etc/rc.local


chef-client -d -i $ARG_I -s $ARG_S -c /etc/chef/client.rb -E "$ARG_E" -r "$ARG_R" -L /var/log/chef-client.log


echo "resourcemgr ui: http://$ipaddress:50070"
echo "node manager ui:http://$ipaddress:8042"
echo "yarn resource manager ui:http://$ipaddress:8088"

echo "SLEEPING...."
sleep 100000





