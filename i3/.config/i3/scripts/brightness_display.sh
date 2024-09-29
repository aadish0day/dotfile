#!/bin/bash

# Using brightnessctl (install if not available)
brightness=$(brightnessctl -m | cut -d',' -f4 | tr -d '%')

# Alternatively, using light (uncomment the next line if you use `light`)
# brightness=$(light -G | cut -d '.' -f 1)

# Alternatively, using sysfs interface (uncomment if you don't have `brightnessctl` or `light`)
# max_brightness=$(cat /sys/class/backlight/intel_backlight/max_brightness)
# current_brightness=$(cat /sys/class/backlight/intel_backlight/brightness)
# brightness=$(( current_brightness * 100 / max_brightness ))

echo "$brightness%"

