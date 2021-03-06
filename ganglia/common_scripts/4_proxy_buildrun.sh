#/bin/bash

TEMP=`getopt -o h:p:i: --long proxyhost:,proxyport:,isproxy: -n 'test.sh' -- "$@"`
eval set -- "$TEMP"

# extract options and their arguments into variables.
ARG_PROXYHOST='192.168.0.21'
ARG_PROXYPORT='8080'
ARG_ISPROXY=true
while true ; do
    case "$1" in
        -h|--proxyhost)
            case "$2" in
                *) ARG_PROXYHOST=$2 ; shift 2 ;;
            esac ;;
        -p|--proxyport)
            case "$2" in
                *) ARG_PROXYPORT=$2 ; shift 2 ;;
            esac ;;
       -i|--isproxy)
            case "$2" in
                *) ARG_ISPROXY=$2 ; shift 2 ;;
            esac ;;
        --) shift ; break ;;
        *) echo "other option is provided!";;
    esac
done


proxyhost=$ARG_PROXYHOST
proxyport=$ARG_PROXYPORT
isproxy=$ARG_ISPROXY

unset http_proxy
unset https_proxy


sed -i '/http_proxy/d' /root/.bashrc
sed -i '/https_proxy/d' /root/.bashrc
sed -i '/ftp_proxy/d' /root/.bashrc

if  [ "$isproxy" = true ]; then
  echo "PTI: using proxy"
  #TODO
  #astek proxy
  echo "Acquire::http::Proxy \"http://$proxyhost:$proxyport\";" > /etc/apt/apt.conf.d/proxy
  echo "export http_proxy=http://$proxyhost:$proxyport/" >> /root/.bashrc
  echo "export https_proxy=http://$proxyhost:$proxyport/" >> /root/.bashrc
  echo "export ftp_proxy=http://$proxyhost:$proxyport/" >> /root/.bashrc
  export http_proxy=http://$proxyhost:$proxyport/
  export https_proxy=http://$proxyhost:$proxyport/
  env http_proxy=http://$proxyhost:$proxyport/
  env https_proxy=http://$proxyhost:$proxyport/
   
 
  cat << EOF1 > /root/.wgetrc
http_proxy = http://$proxyhost:$proxyport/
use_proxy = on
wait = 15
EOF1


  cat << EOF2 > /root/.curlrc
proxy = http://$proxyhost:$proxyport/
EOF2

  mkdir -p /root/.m2

  cat << EOF >  /root/.m2/settings.xml
<settings>
  <proxies>
   <proxy>
      <active>true</active>
      <protocol>http</protocol>
      <host>$proxyhost</host>
      <port>$proxyport</port>
    </proxy>
  </proxies>
</settings>
EOF

 cat << EOF2 >  /root/.gitconfig
[http]
        proxy = http://$proxyhost:$proxyport
[https]
        proxy = http://$proxyhost:$proxyport

EOF2


mkdir /root/.pip
cat << EOF3 >  /root/.pip/pip.conf
[global]
proxy = $proxyhost:$proxyport
EOF3


else
  echo "PTI: no proxy"
  rm -f /etc/apt/apt.conf.d/proxy
  rm -f /root/.wgetrc
  rm -f /root/.m2/settings.xml
  rm -f /root/.curlrc
  rm -f /root/.gitconfig
  rm -f /root/.pip/pip.conf
fi

. /root/.bashrc

#diag
echo "diagnostics"
echo "1� apt proxy"
cat /etc/apt/apt.conf.d/proxy
echo "2) bashrc proxy"
cat /root/.bashrc | grep proxy
echo "3) wget proxy"
cat /root/.wgetrc
echo "4) maven proxy"
cat /root/.m2/settings.xml
echo "5) env proxy"
env | grep proxy

exit 0 
