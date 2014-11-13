#!/bin/bash
for paquet in $1/*.deb; do
  reprepro -b . includedeb precise $paquet;
done

