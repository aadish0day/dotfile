#!/bin/bash

# Kill any running Gammastep instances
killall -q gammastep

# Wait for the process to stop
while pgrep -x gammastep >/dev/null; do sleep 1; done

# Start Gammastep with your config
gammastep -c ~/.config/gammastep/config.ini &
