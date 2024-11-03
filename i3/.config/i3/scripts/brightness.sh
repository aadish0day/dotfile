#!/bin/bash

# Define the step for brightness change
brightness_step=10

# Uses brightnessctl to get the current brightness as a percentage
function get_brightness {
	max_brightness=$(brightnessctl m)     # Maximum brightness value
	current_brightness=$(brightnessctl g) # Current brightness value
	echo $((current_brightness * 100 / max_brightness))
}

# Returns the brightness icon based on the brightness level
function get_brightness_icon {
	brightness=$(get_brightness)
	if ((brightness <= 20)); then
		echo "󰃞" # Low brightness icon
	elif ((brightness <= 60)); then
		echo "󰃟" # Medium brightness icon
	else
		echo "󰃠" # High brightness icon
	fi
}

# Displays a brightness notification using dunstify
function show_brightness_notif {
	brightness=$(get_brightness)
	brightness_icon=$(get_brightness_icon)
	bar_color="${bar_color:-#FFD700}" # Set default color if not provided
	dunstify -t 1000 -r 2593 -u normal "$brightness_icon $brightness%" -h int:value:"$brightness" -h string:hlcolor:"$bar_color"
}

# Main function - Takes user input, "brightness_up" or "brightness_down"
case $1 in
brightness_up)
	# Increases brightness and displays the notification
	brightnessctl set +"$brightness_step"%
	show_brightness_notif
	;;

brightness_down)
	# Decreases brightness and displays the notification
	brightnessctl set "$brightness_step"%-
	show_brightness_notif
	;;
*)
	echo "Usage: $0 {brightness_up|brightness_down}"
	;;
esac
