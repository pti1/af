#!/usr/bin/env bash

proxyhost="192.168.0.21"
proxyport="8080"
isproxy=true

unset http_proxy
unset https_proxy


sed -i '/export http_proxy/d' /root/.bashrc
sed -i '/export https_proxy/d' /root/.bashrc

if  [ "$isproxy" = true ]; then
  echo "PTI: using proxy"
  #TODO
  #astek proxy
  echo "Acquire::http::Proxy \"http://$proxyhost:$proxyport\";" > /etc/apt/apt.conf.d/proxy
  echo "export http_proxy=http://$proxyhost:$proxyport/" >> /root/.bashrc
  echo "export https_proxy=http://$proxyhost:$proxyport/" >> /root/.bashrc
  export http_proxy=http://$proxyhost:$proxyport/
  export https_proxy=http://$proxyhost:$proxyport/

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
else
  echo "PTI: no proxy"
  rm -f /etc/apt/apt.conf.d/proxy
  rm -f /root/.wgetrc
  rm -f /root/.m2/settings.xml
  rm -f /root/.curlrc
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


