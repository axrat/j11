#!/bin/bash
sudo chmod 777 $(cd $(dirname $0); pwd) -Rf
sudo find /j11/ -type d -exec sudo chmod 777 {} +
sudo find /j11/ -type f -exec sudo chmod 666 {} +