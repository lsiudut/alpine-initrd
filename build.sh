#!/bin/bash

set -e -x

pushd .
cd docker/ && docker build -t lucks/alpine-builder .
popd

sudo rm -rf alpine/ &&
  mkdir alpine

sudo docker run -t -i --rm -v "$PWD/alpine/:/alpine/" lucks/alpine-builder

cd alpine/ && \
  sudo find . | sudo cpio -o -H newc | xz -C crc32 -z -c - > ../alpine-initrd.xz
