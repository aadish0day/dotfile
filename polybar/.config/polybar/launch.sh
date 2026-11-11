#!/usr/bin/env bash

# Terminate already running Polybar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch Polybar in background disowned
polybar main </dev/null &>/dev/null &

