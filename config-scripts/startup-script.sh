#!/usr/bin/env bash

bash -c 'apt update && apt upgrade -y && apt autoremove -y'
apt install -y ruby-full ruby-bundler build-essential

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E52529D4
bash -c 'echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.0 multiverse" > /etc/apt/sources.list.d/mongodb-org-4.0.list'
apt update
apt install -y mongodb-org
systemctl enable mongod
systemctl start mongod

mkdir /usr/reddit.express42
cd /usr/reddit.express42
git clone -b monolith git://github.com/express42/reddit.git
cd /usr/reddit.express42/reddit && bundle install
puma -d
