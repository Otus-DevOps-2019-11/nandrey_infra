#!/usr/bin/env bash

echo
echo "Hello Dave, I will run a couple of checks before installation"
echo

wget -q --spider http://google.com

if [ $? -eq 0 ]; then
    echo
    echo "Internet is reachable, Dave"
else
    echo
    echo "Error: Sorry, but host can't reach Internet, Dave"
    exit
fi



echo
echo "I will install MongoDB on system, Dave"
echo

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E52529D4
bash -c 'echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.0 multiverse" > /etc/apt/sources.list.d/mongodb-org-4.0.list'

echo
echo "I will try to update the repository data, Dave"
echo

apt update

if [ $? -eq 0 ]; then
    echo
    echo "Repositoris are up to date, Dave"
    echo
else
    echo
    echo "Error: Something wrong with updates, Dave"
    echo
    exit
fi

apt install -y mongodb-org



echo
echo "I will start the Database for you, Dave"
echo
systemctl enable mongod
systemctl start mongod

if [ $? -eq 0 ]; then
    echo
    echo "Database is started, Dave"
    systemctl status mongod
else
    echo
    echo "Error: Something wrong with updates, Dave"
    systemctl status mongo
    exit
fi

echo
echo "MongoDB is installed and started, Dave"
echo
