#!/bin/bash

sleep 30

sudo apt-get update 
sudo apt-get upgrade -y

# update kernel
sudo apt-get -y install linux-image-5.0.0-23-generic
sudo apt-get -y install linux-headers-5.0.0-23-generic

# reboot
sudo reboot
