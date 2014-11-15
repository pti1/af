#!/bin/bash
for paquet in $1/*.deb; do
   dpkg-sig --sign builder $paquet
   reprepro -b /var/packages/ubuntu/ includedeb precise $paquet;
done

