#!/bin/bash
sudo chmod 777 $(cd $(dirname $0); pwd) -Rf
sudo find /v/ -type d -exec sudo chmod 777 {} +
sudo find /v/ -type f -exec sudo chmod 666 {} +
sudo chmod 700 ${0##*/}
