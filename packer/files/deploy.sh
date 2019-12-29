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
