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
installdein(){
mkdir -p ~/.vim
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.vim/dein
rm installer.sh
}
installubuntudesktop(){
  sudo apt-get install ubuntu-desktop --fix-missing -y
}
installvirtualboxarch(){
##Arch Linux Kernel
sudo pacman -S virtualbox
##install with virtualbox-host-modules(Depegency
sudo pacman -S dkms kernel-headers
sudo pacman -S virtualbox-guest-dkms
sudo pacman -S virtualbox-host-dkms
dkms install vboxhost/$(pacman -Q virtualbox|awk {'print $2'}|sed 's/\-.\+//') -k $(uname -rm|sed 's/\ /\//')
sudo /sbin/rcvboxdrv setup
}
