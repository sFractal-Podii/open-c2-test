#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
     echo "its linux-gnu"
      sudo apt install -y mosquitto
elif [[ "$OSTYPE" == "darwin"* ]]; then
        # Mac OSX
        echo "its darwin"
        HOMEBREW_NO_AUTO_UPDATE=1 brew install mosquitto
elif [[ "$OSTYPE" == "cygwin" ]]; then
        # POSIX compatibility layer and Linux environment emulation for Windows
        echo "its cygwin"
elif [[ "$OSTYPE" == "msys" ]]; then
        # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
        echo "its msys"
elif [[ "$OSTYPE" == "win32" ]]; then
        # I'm not sure this can happen.
        echo "its win32"
elif [[ "$OSTYPE" == "freebsd"* ]]; then
        # ...
        echo "its freebsd"
else
       echo "unknown"
fi


echo “Test script executing mosquitto command....”

echo $1

# mosquitto_pub -h "test.mosquitto.org" -t "sfractal/command" -m $1
