#!/bin/bash

echo "NOTE: THE MOSQUITTO BROKER NEEDS TO BE INSTALLED TO EXECUTE THIS SCRIPT SUCCESSFULLY"
echo "FOR LINUX INSTALLATION follow this link https://www.vultr.com/docs/install-mosquitto-mqtt-broker-on-ubuntu-20-04-server/"
echo "FOR MAC INSTALLATION follow this link https://subscription.packtpub.com/book/application-development/9781787287815/1/ch01lvl1sec12/installing-a-mosquitto-broker-on-macos"

read -p "Press enter to continue when mosquitto is successfully installed or if you already have mosquitto"

echo "Test script executing mosquitto command...."

echo "$1"

mosquitto_pub -h "test.mosquitto.org" -t "sfractal/command" -m "$1"
