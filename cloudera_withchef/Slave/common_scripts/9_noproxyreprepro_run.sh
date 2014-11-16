#!/bin/bash
# detect-http-proxy - Returns a HTTP proxy which is available for use

curl fr.archive.ubuntu.com
if [ $? -ne 0 ];
then
  echo "no internet, remove apt source lists"
  rm -f /etc/apt/sources.list
  rm -f /etc/apt/sources.list.d/*
fi

echo "deb http://aptrepo.example.com debian/" > /etc/apt/sources.list.d/reprepro.list

cat <<EOT >> /etc/apt/apt.conf.d/proxy
Acquire::http::Timeout "1";
Acquire::ftp::Timeout "1";
Acquire::Retries "1";

#Override the default proxy, DIRECT causes a direct connection to be used
Acquire::http::Proxy {
    aptrepo.example.com DIRECT;
};

APT::Get::Assume-Yes "true";
APT::Get::force-yes "true";
APT::Get::Fix-Broken "true";
EOT

apt-get update
