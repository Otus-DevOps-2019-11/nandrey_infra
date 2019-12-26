#!/usr/bin/env bash

echo "Hello Dave, I'll run a couple of checks before installation"
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
echo "I will install Reddit for you, Dave"
echo

mkdir /usr/reddit.express42
cd /usr/reddit.express42
git clone -b monolith git://github.com/express42/reddit.git
cd /usr/reddit.express42/reddit && bundle install

if [ $? -eq 0 ]; then
    echo
    echo "Reddit is here, Dave"
else
    echo
    echo "Error: Something wrong with Reddit installation, Dave"
    exit
fi



echo
echo "I will try run Puma server, Dave"
echo

puma -d

echo
echo "Notice the Port Number, Dave"
ps aux | grep puma

if [ $? -eq 0 ]; then
    echo
    echo "Puma is up and running, Dave"
else
    echo
    echo "Something wrong with Puma installation, Dave"
    exit
fi

echo
echo "Have a good day, Dave"
echo
