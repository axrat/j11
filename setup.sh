#!/bin/bash
sudo chmod 777 $(cd $(dirname $0); pwd) -Rf
sudo find /j11/ -type d -exec sudo chmod 777 {} +
sudo find /j11/ -type f -exec sudo chmod 666 {} +
sudo chmod 700 ${0##*/}

#nanorc
if [ -d ~/.nano ]; then
  echo found ~/.nano
else
  DOWNLOAD=nanorc.zip
  if [ -e $DOWNLOAD ]; then
    echo "found $DOWNLOAD"
  else
    echo "not found $DOWNLOAD"
    wget --no-check-certificate https://github.com/nanorc/nanorc/archive/master.zip -O nanorc.zip
    unzip $DONWLOAD
    cd nanorc-master
    make install
    cd ..
    rm -rf nanorc-master
    rm -f $DOWNLOAD
  fi
fi
