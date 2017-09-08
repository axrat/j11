#!/bin/bash

installubuntuoraclejdk(){
 sudo add-apt-repository ppa:webupd8team/java
 sudo apt-get update
 sudo apt-get install oracle-java8-installer
}
installtrans(){
#https://github.com/soimort/translate-shell
DIR=/usr/local/bin/
if [ ! -e ${DIR}trans ]; then
  wget git.io/trans
  chmod +x ./trans
  sudo mv ./trans $DIR
fi
}
installnanorc(){
rm -rf ~/.nano
git clone https://github.com/nanorc/nanorc.git
cd nanorc
make install
cd ..
sudo rm -rf nanorc
}
ubuntuinstallntp(){
sudo apt-get install ntp
sudo /etc/init.d/ntp start
}
installpip(){
wget https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py
rm get-pip.py
}
