#!/bin/bash

set -e
mv /tmp/puma.service /etc/systemd/system/puma.service
chmod 775 /etc/systemd/system/puma.service
#install reddit
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
systemctl enable puma
