#!/usr/bin/env bash
#
# Simple script to change power profiles using rofi and powerprofilesctl
#

# Colors for rofi
FG_COLOR="#bbbbbb"
BG_COLOR="#111111"
HLFG_COLOR="#111111"
HLBG_COLOR="#bbbbbb"
BORDER_COLOR="#222222"

# Rofi options
ROFI_OPTIONS=(-theme ~/.config/rofi/power-profiles.rasi)

# Check for required commands
if ! command -v rofi &>/dev/null || ! command -v powerprofilesctl &>/dev/null; then
    echo "Error: 'rofi' and 'powerprofilesctl' are required."
    exit 1
fi

# Define menu options and their corresponding commands
declare -A menu_options=(
    [Performance]="powerprofilesctl set performance"
    [Balanced]="powerprofilesctl set balanced"
    [Power\ Saver]="powerprofilesctl set power-saver"
)

# Launch rofi to select a profile
selection=$(printf "%s\n" "${!menu_options[@]}" | sort | rofi -dmenu -i -p "Select Power Profile:" \
    -bg "$BG_COLOR" -fg "$FG_COLOR" -hlfg "$HLFG_COLOR" -hlbg "$HLBG_COLOR" "${ROFI_OPTIONS[@]}")

# If selection is not empty, apply the selected profile
if [[ -n "$selection" ]]; then
    ${menu_options[$selection]}
fi

