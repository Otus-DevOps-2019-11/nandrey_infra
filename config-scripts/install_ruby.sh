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
echo "I will try to update the system, Dave"
echo

bash -c 'apt update && apt upgrade -y && apt autoremove -y'

if [ $? -eq 0 ]; then
    echo
    echo "System is updated, Dave"
else
    echo
    echo "Error: Something wrong with updates, Dave"
    exit
fi


echo
echo "I will try to install Ruby and essentials, Dave"

apt install -y ruby-full ruby-bundler build-essential

if [ $? -eq 0 ]; then
    echo
    echo "Ruby and essentials is installed, Dave"
else
    echo
    echo "Something wrong with Ruby packeges, Dave"
    exit
fi

echo
echo "Have a good day, Dave"
echo
