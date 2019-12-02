#!/usr/bin/env bash

cd /opt/openstack-ansible
sudo git checkout 19.0.4
sudo ./scripts/run-upgrade.sh
