#!/bin/bash

bar_color="#7f7fff"
volume_step=1
max_volume=100

get_volume() {
    pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | tr -d '%'
}

get_volume_icon() {
    local volume
    volume=$(get_volume)
    if [ "$volume" -eq 0 ]; then
        echo ""
    elif [ "$volume" -lt 50 ]; then
        echo ""
    else
        echo ""
    fi
}

show_volume_notif() {
    local volume icon
    volume=$(get_volume)
    icon=$(get_volume_icon)
    dunstify -i audio-volume-muted-blocking -t 1000 -r 2593 -u normal "$icon $volume%" -h int:value:$volume -h string:hlcolor:$bar_color
}

case $1 in
    volume_up)
        pactl set-sink-mute @DEFAULT_SINK@ 0
        pactl set-sink-volume @DEFAULT_SINK@ +${volume_step}%
        show_volume_notif
        ;;
    
    volume_down)
        pactl set-sink-volume @DEFAULT_SINK@ -${volume_step}%
        show_volume_notif
        ;;
    
    *)
        echo "Usage: $0 {volume_up|volume_down}"
        exit 1
        ;;
esac

