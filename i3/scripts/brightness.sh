#!/bin/bash

# Define the step for brightness change
brightness_step=5

# Uses regex to get brightness from brightnessctl
function get_brightness {
    brightnessctl g | awk '{print int($1*100/255)}'
}

# Always returns the same icon - a sun icon for brightness
function get_brightness_icon {
    brightness_icon="󰃞"
}

# Displays a brightness notification using dunstify
function show_brightness_notif {
    brightness=$(get_brightness)
    get_brightness_icon
    dunstify -t 1000 -r 2593 -u normal "$brightness_icon $brightness%" -h int:value:$brightness -h string:hlcolor:$bar_color
}

# Main function - Takes user input, "brightness_up" or "brightness_down"
case $1 in
brightness_up)
    # Increases brightness and displays the notification
    brightnessctl set +$brightness_step%
    show_brightness_notif
    ;;

brightness_down)
    # Decreases brightness and displays the notification
    brightnessctl set $brightness_step%-
    show_brightness_notif
    ;;
esac

