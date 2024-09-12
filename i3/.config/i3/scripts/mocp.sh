#!/bin/bash

# Get the current playing song info
info=$(mocp -Q '%song')

# Check if MOC is running and playing
if [ -z "$info" ]; then
    echo "No song playing"
else
    echo "$info"
fi

