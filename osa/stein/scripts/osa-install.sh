#!/usr/bin/env bash

sudo apt-get update
sudo apt install python3-pip
sudo ln -s /usr/bin/pip3 /usr/bin/pip
sudo pip install --upgrade pip
git clone https://github.com/openstack/openstack-ansible-ops.git
cd openstack-ansible-ops/multi-node-aio
export OSA_BRANCH=stable/stein
export DEFAULT_IMAGE=ubuntu-18.04-amd64
echo nameserver 8.8.8.8 >> /etc/resolv.conf
sudo ./build.sh
