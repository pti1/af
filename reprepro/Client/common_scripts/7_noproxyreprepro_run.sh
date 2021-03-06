#!/bin/bash
# detect-http-proxy - Returns a HTTP proxy which is available for use


cat <<EOT >> /etc/apt/apt.conf.d/proxy
Acquire::http::Timeout "1";
Acquire::ftp::Timeout "1";
Acquire::Retries "1";

#Override the default proxy, DIRECT causes a direct connection to be used
Acquire::http::Proxy {
    reprepro.example.com DIRECT;
};

EOT
