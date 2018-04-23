#!/bin/bash
set -e
if [ -e /fio_from_source_installed ];then
  echo "fio_from_source_installed exists."
  exit 0
fi
cd /tmp
tar xf fio.tar.gz
cd /tmp/fio-*
./configure
make
make install
rm -rf /tmp/fio*
touch /fio_from_source_installed
