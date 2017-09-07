#!/bin/bash

forDotSSH(){
  sudo find ~/.ssh/ -type d -exec sudo chmod 755 {} +
  sudo find ~/.ssh/ -type f -exec sudo chmod 600 {} +
}
forParentDir(){
  sudo chmod 777 ../`pwd | awk -F "/" '{ print $NF }'`
}
forSudo(){
chown root:root /usr/bin/sudo && chmod 4755 /usr/bin/sudo
chmod u+s "$(command -v su)" "$(command -v sudo)"
}
forNodejs(){
#sudo chown -R $(whoami) $(npm config get prefix)/lib/node_modules
#rm -rf node_modules/ && npm cache clean && npm install
sudo chmod 770 $NVM_DIR -R
}

