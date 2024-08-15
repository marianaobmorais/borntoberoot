#!/bin/bash

MIN=$(uptime -s | cut -d ":" -f 2)
SEC=$(uptime -s | cut -d ":" -f 3)
DELAY=$((MIN % 10 * 60 + SEC))

sleep $DELAY
