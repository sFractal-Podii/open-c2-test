#!/bin/bash

echo “Test script executing mosquitto command....”

mosquitto_pub -h "test.mosquitto.org" -t "sfractal/command" -m '{"action": "set", "target": {"x-sfractal-blinky:led": "rainbow"}, "args": {"response_requested": "complete"}}'
