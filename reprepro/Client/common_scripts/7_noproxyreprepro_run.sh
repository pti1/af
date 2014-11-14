#!/bin/bash
# detect-http-proxy - Returns a HTTP proxy which is available for use


cat <<EOT >> /etc/apt/apt.conf.d/proxy

#Override the default proxy, DIRECT causes a direct connection to be used
Acquire::http::Proxy {
    reprepro.example.com DIRECT;
};

EOT
