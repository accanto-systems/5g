#!/bin/bash

sudo apt-get update 
sudo apt-get upgrade -y

cd /home/ubuntu

# install mongodb
sudo apt -y install mongodb wget git build-essential
sudo systemctl disable mongodb

# install go
wget https://dl.google.com/go/go1.12.9.linux-amd64.tar.gz
tar -zxf go1.12.9.linux-amd64.tar.gz
sudo mv go /usr/local
mkdir -p /home/ubuntu/go/bin
mkdir -p /home/ubuntu/go/pkg
mkdir -p /home/ubuntu/go/src
export GOPATH=/home/ubuntu/go
export GOROOT=/usr/local/go
export PATH=$PATH:$GOPATH/bin:$GOROOT/bin
export GO111MODULE=off

sudo apt -y update
sudo apt -y install git gcc cmake autoconf libtool pkg-config libmnl-dev libyaml-dev
go get -u github.com/sirupsen/logrus

# install control plane
cd $GOPATH/src
git clone https://github.com/free5gc/free5gc.git
cd free5gc
git submodule update --init

cd $GOPATH/src/free5gc
chmod +x ./install_env.sh
./install_env.sh
./build.sh

# install gtp module
git clone https://github.com/PrinzOwO/gtp5g.git
cd gtp5g
make clean && make
sudo make install
cd /home/ubuntu

#build upf
cd $GOPATH/src/free5gc/src/upf
cd build
cmake ..
make -j`nproc`