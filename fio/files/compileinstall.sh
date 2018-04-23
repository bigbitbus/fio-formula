#!/bin/bash
set -e
if [ -e /stressng_from_source_installed ];then
  echo "libgit2+pygit2 already installed from source - /stressng_from_source_installed exists."
  exit 0
fi
cd /tmp
tar xf stress-ng-*
cd /tmp/stress-ng-*
make
cp stress-ng /usr/bin
cd /tmp
rm -rf /tmp/stress-*
touch /stressng_from_source_installed
